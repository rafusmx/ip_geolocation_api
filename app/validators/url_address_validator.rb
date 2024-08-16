class UrlAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if valid_url?(value)

    record.errors.add(attribute, :invalid_url_address)
  end

  private

  def valid_url?(address)
    uri = URI.parse(address)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end
