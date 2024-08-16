class LocationDataController < ApplicationController
  before_action :analize_request_address

  def create
    @ip_data = add_location_data

    render :show, status: :created
  end

  def destroy
    ip_data = load_location_data
    return unless ip_data

    ip_data.destroy

    if ip_data.errors.any?
      render_error(message: ip_data.errors.full_messages, status: :internal_server_error)
    else
      render json: { message: "Successfully removed records", address: params[:address] }, status: :ok
    end
  end

  def show
    @ip_data = load_location_data

    render :show, status: :ok if @ip_data
  end

  private

  def analize_request_address
    @request_address = AddressAnalizer.new(params[:address])
    render_invalid_addres unless @request_address.is_valid?
  end

  def load_location_data
    if @request_address.is_url?
      url_address = UrlAddress.find_by(address: @request_address.url)
      ip_data = url_address&.location_datum
    else
      ip_data = LocationDatum.includes(:url_addresses).find_by(ip: @request_address.ip)
    end

    render_not_found unless ip_data

    ip_data
  end

  def add_location_data
    return load_location_data if @request_address.is_url? && UrlAddress.find_by(address: @request_address.url)

    location_data = LocationDatum.find_by(ip: @request_address.ip)

    location_data = create_location_data if location_data.nil?
    location_data.url_addresses.create(address: @request_address.url) if @request_address.is_url?

    location_data
  end

  def create_location_data
    location_data = LocationDatum.new(location_params)
    location_data.ip = @request_address.ip
    location_data.version = @request_address.type
    location_data.save
    location_data
  end

  def location_params
    params.permit(
      :latitude,
      :longitude,
      :continent,
      :country,
      :region,
      :zip
    )
  end

  def render_invalid_addres
    render_error(message: "The address is not valid.", status: :bad_request)
  end

  def render_not_found
    render_error(message: "There are no records for the requested address", status: :not_found)
  end

  def render_error(message: "Bad request", status: :bad_request)
    render json: {
      error: message,
      address: params[:address]
    }, status: status
  end
end
