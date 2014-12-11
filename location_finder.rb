require 'json'

class LocationFinder
  attr_reader :locations

  def initialize(locations)
    file = File.read(locations)
    @locations = json_parse(file)
  end

  def json_parse(file)
    @locations = JSON.parse(file)
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

  def nearest_business_lat(user_lat)
    locations.min_by do |location|
      (location["latitude"].to_f - user_lat).abs
    end
  end

  def nearest_business_long(user_long)
    locations.min_by do |location|
      (location["longitude"].to_f - user_long).abs
    end
  end
end
