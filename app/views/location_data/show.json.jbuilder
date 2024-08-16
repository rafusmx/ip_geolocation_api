json.url @request_address.url if @request_address.is_url?

json.ip @ip_data.ip
json.type @ip_data.version

json.location_data do
  json.latitude @ip_data.latitude
  json.longitude @ip_data.longitude
  json.continent @ip_data.continent
  json.country @ip_data.country
  json.region @ip_data.region
  json.zip @ip_data.zip
end
