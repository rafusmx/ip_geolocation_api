class UrlAddress < ApplicationRecord
  belongs_to :location_datum

  validates_presence_of :address

  def obtain_ip_address
    IPFinder.find(address)
  end
end
