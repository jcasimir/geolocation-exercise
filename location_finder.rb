require 'json'

class LocationFinder
  attr_reader :locations

  def initialize(locations)
    data = File.read(locations)
    @locations = JSON.parse(data)
  end

  def closest_to(user_local)
    usr_lat  = (user_local[:latitude]).to_f
    usr_long = (user_local[:longitude]).to_f
    nearest_lat  = nearest_business_lat(usr_lat)
    nearest_long = nearest_business_long(usr_long)
    lat_diff  = (usr_lat - nearest_lat["latitude"].to_f).abs
    long_diff = (usr_long - nearest_long["longitude"].to_f).abs
    lat_diff < long_diff ? nearest_lat : nearest_long
  end

  def nearest_business_lat(target_lat)
    locations.min_by do |location|
      (location["latitude"].to_f - target_lat).abs
    end
  end

  def nearest_business_long(target_long)
    locations.min_by do |location|
      (location["longitude"].to_f - target_long).abs
    end
  end
end
