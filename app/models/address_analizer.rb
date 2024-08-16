require 'resolv'
class AddressAnalizer

  attr_reader :ip, :type, :url

  def initialize(request_address)
    analize_address(request_address)
  end

  def is_url?
    @url.present?
  end

  def is_ip?
    @ip.present? && !is_url?
  end

  def is_valid?
    @ip.present? && @type.present?
  end

  private

  def analize_address(request_address)
    if valid_url?(request_address)
      get_url_ip
    else
      analize_ip(request_address)
    end
  end

  def get_url_ip
    @url = @uri.host
    url_ip = Resolv.getaddress(@url)
    analize_ip(url_ip)
  rescue Resolv::ResolvError
    Rails.logger.error("URL cannot be resolved: #{@url}")
  end

  def analize_ip(address)
    @ip = address
    if valid_ipv4?(address)
      @type = "ipv4"
    elsif valid_ipv6?(address)
      @type = "ipv6"
    else
      @ip = nil
    end
  end

  def valid_ipv4?(address)
    !!(address =~ /\A(?:\d{1,3}\.){3}\d{1,3}\z/ && address.split('.').map(&:to_i).all? { |octet| octet.between?(0, 255) })
  end

  def valid_ipv6?(address)
    !!(address =~ /\A(?:[a-fA-F0-9]{1,4}:){7}[a-fA-F0-9]{1,4}\z/ || address =~ /\A(?:[a-fA-F0-9]{1,4}:){1,7}:?\z/)
  end

  def valid_url?(address)
    @uri = URI.parse(address)
    @uri.is_a?(URI::HTTP) || @uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end
