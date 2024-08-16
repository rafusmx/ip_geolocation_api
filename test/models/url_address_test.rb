require "test_helper"

class UrlAddressTest < ActiveSupport::TestCase
  test "should not save without ip information" do
    data = UrlAddress.new

    assert_not data.save, "Saved article without address"
  end

  test "should not save record without location data" do
    params = { address: "my.address.test" }
    data = UrlAddress.new(params)
    assert_not data.save, "Saved with address value"
  end

  test "should save record with address and location data" do
    reference = location_data(:one)
    params = { address: "my.address.test", location_datum: reference }
    data = UrlAddress.new(params)
    assert data.save, "Saved with reference"
  end
end
