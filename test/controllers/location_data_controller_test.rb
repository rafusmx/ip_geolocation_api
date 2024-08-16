require "test_helper"

class LocationDataControllerTest < ActionDispatch::IntegrationTest
  test "should respond on create create" do
    request_params = { address: "192.168.1.5", latitude: 37.419158935546875, longitude: -6.243330001831055 }
    post location_data_url(params: request_params, format: :json)
    assert_response :success
  end

  test "should add a record on create" do
    request_params = { address: "https://www.test.net" }
    assert_difference "UrlAddress.count" do
      post location_data_url(params: request_params, format: :json)
    end
  end

  test "should add a record with all details create" do
    request_params = { address: "192.168.1.5",
                       latitude: 37.419158935546875,
                       longitude: -6.243330001831055,
                       continent: "Europe",
                       country: "England",
                       region: "Lincolnshire",
                       zip: "DN10 4BE"}
    assert_difference "LocationDatum.count" do
      post location_data_url(params: request_params, format: :json)
    end
    record = LocationDatum.last
    assert record.ip == request_params[:address]
    assert record.zip == request_params[:zip]
    assert record.region == request_params[:region]
    assert record.country == request_params[:country]
    assert record.continent == request_params[:continent]
    assert record.latitude == request_params[:latitude].to_s
    assert record.longitude == request_params[:longitude].to_s
    assert record.version.present?
  end

  test "should get response on destroy" do
    record = location_data(:one)

    delete location_data_url(address: record.ip)
    assert_response :success
  end

  test "should delete record on destroy" do
    record = location_data(:one)
    assert_difference "LocationDatum.count", -1 do
      delete location_data_url(address: record.ip)
    end
  end

  test "should get IP location data on show" do
    record = location_data(:one)

    get location_data_url(address: record.ip, format: :json)
    assert_response :success
  end

  test "should get URL location data on show" do
    record = location_data(:googletagmanager)
    url_record = record.url_addresses.first

    get location_data_url(address: "https://#{url_record.address}", format: :json)
    assert_response :success
  end
end
