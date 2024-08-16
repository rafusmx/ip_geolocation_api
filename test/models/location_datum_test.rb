require "test_helper"

class LocationDatumTest < ActiveSupport::TestCase
  test "should not save without ip information" do
    data = LocationDatum.new

    assert_not data.save, "Saved article without ip information"
  end

  test "should validate record with a valid IPv4 address" do
    params = { ip: "192.168.1.5", version: "ipv4" }
    data = LocationDatum.new(params)
    assert data.valid?, "validate with minimum set of parameters"
  end

  test "should validate record with a valid IPv6 address" do
    params = { ip: "145a:cf4a:aaa9:c1a1:d5de:4bfe:e9cf:74b7", version: "ipv6" }
    data = LocationDatum.new(params)
    assert data.valid?, "Saved with minimum set of parameters"
  end

  test "should not allow IP version to be other than ipv4 or ipv6" do
    params = { ip: "192.168.1.5", version: "ipv8" }
    data = LocationDatum.new(params)
    assert_not data.valid?
  end

  test "should not allow invalid IP address to be saved" do
    params = { ip: "192.168.1.258", version: "ipv4" }
    data = LocationDatum.new(params)
    assert_not data.valid?, "Saved with invlaid IPv4 address"
  end

end
