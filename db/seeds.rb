require 'csv'

raw_csv = File.read(Rails.root.join('lib', 'seeds', 'seed_data.csv'))
csv = CSV.parse(raw_csv, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|
  location_record = LocationDatum.find_or_create_by(
    ip: row["ip"],
    version: row["version"],
    continent: row["continent"],
    country: row["country"],
    region: row["region"],
    zip: row["zip"],
    latitude: row["latitude"],
    longitude: row["longitude"]
    )
  UrlAddress.find_or_create_by(address: row["url"], location_datum_id: location_record.id) if row["url"]
end
