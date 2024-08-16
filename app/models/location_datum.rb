class LocationDatum < ApplicationRecord
  has_many :url_addresses, dependent: :destroy

  enum version: [:ipv4, :ipv6]

  validates_uniqueness_of :ip
  validates_inclusion_of :version, in: ["ipv4", "ipv6"]
  validates :ip, ip_address: true

  def version=(value)
    super
  rescue ArgumentError
    self.errors.add("#{value} is not a valid IP version")
  end
end
