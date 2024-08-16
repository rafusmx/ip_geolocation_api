class IpAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if valid_ip?(value)

    record.errors.add(attribute, :invalid_ip_address)
  end

  private

  def valid_ip?(address)
    (address =~ /\A(?:\d{1,3}\.){3}\d{1,3}\z/ && address.split('.').map(&:to_i).all? { |octet| octet.between?(0, 255) }) ||
      (address =~ /\A(?:[a-fA-F0-9]{1,4}:){7}[a-fA-F0-9]{1,4}\z/ || address =~ /\A(?:[a-fA-F0-9]{1,4}:){1,7}:?\z/)
  end
end
