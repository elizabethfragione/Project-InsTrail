require 'test_helper'

class MapTest < ActiveSupport::TestCase
  
  test "point is in vancouver" do
    lat_lon = Geocoder.coordinates("Lynn Canyon Park")
    assert in_vancouver(lat_lon), "point is in Vancouver"
  end
  
  test "point is NOT in vancouver" do
    lat_lon = Geocoder.coordinates("Cable Bay Trail")
    assert in_vancouver(lat_lon), "point is NOT in Vancouver"
  end
  
end
