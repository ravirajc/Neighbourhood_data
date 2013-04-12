require 'rubygems'

require 'json'
require 'rest_client'
require 'uri/http'
#area="jp nagar"
#url = "http://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA"




def get_lat_lng(search_term)
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyD1eA_mMwy_51cCkRHu06g2GeFw8rdJmgU&location=12.9923408,77.5947617&sensor=false&radius=50000&keyword=#{search_term}"
  p URI::escape(url)
  response = JSON.parse(RestClient.get(URI::escape(url)), :symbolize_names => true )
  p response
  location_hash = response[:results][0][:geometry][:location]
  lat = location_hash[:lat]
  lng = location_hash[:lng]
  name = response[:results][0][:name]
  [name, lat, lng]

end


def neighbourhoods
  neighbourhoods_file = File.open("output.txt","r")
  neighbourhoods_file.readlines
end

file_name = "lat_long.txt"
output_file = File.open(file_name, "w")

neighbourhoods.each do |place|
  (name, lat, lng) = get_lat_lng(place)
  output_file << name << "," << lat << "," << lng << "\n"
  p name
  p lat
  p lng
end
output_file.close
