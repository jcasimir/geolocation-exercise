require 'minitest/autorun'
require 'pry'
require_relative 'location_finder'

class LocateTest < Minitest::Test

  def setup
    @user_local = {:latitude => "50.558", :longitude => "10.347"}
  end

  def test_can_load_json
    finder = LocationFinder.new('locations.json')
    assert_equal 100, finder.locations.count
  end

  def test_nearest_lat
    finder = LocationFinder.new('locations.json')
  end

  def test_closest_to
    finder = LocationFinder.new('locations.json')
    nearest_biz = finder.closest_to(@user_local)
    assert_equal "Hammes and Sons", nearest_biz["name"]
  end
end