class External::Ipstack
  require 'rest-client'

  class << self
    def find_location(ip_address)
      get_location_data(ip_address)
    end

    # Not supported on free plan
    # def find_batch(ip_addresses)
    #   ip_addresses = [ip_addresses] unless ip_addresses.is_a? Array

    #   request_addresses = ip_addresses.join(",")

    #   get_location_data(request_addresses)
    # end

    private

    BASE_URL = "https://api.ipstack.com".freeze
    ACCESS_KEY = ENV["IPSTACK_KEY"]

    def get_location_data(request_address)
      response = RestClient::Request.new(method: :get, url: url_string(request_address)).execute

      JSON.parse(response.to_s)
    end

    def url_string(request_address)
      "#{BASE_URL}/#{request_address}?access_key=#{ACCESS_KEY}&fields=#{requested_fields}"
    end

    def requested_fields
      %w[
        continent_name
        country_name
        region_name
        zip
        latitude
        longitude
      ].join(",")
    end
  end
end
