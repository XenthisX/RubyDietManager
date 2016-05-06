require_relative 'food_db'
require 'test/unit'

class TestFoodDB < Test::Unit::TestCase

  def test_create_basic_food
    food_db = Hash.new(0)
    temp = FoodDB.new.parse_line(['Orange','b','70'],food_db)
    assert_equal(temp.name, BasicFood.new('Orange', '70').name, 'The parse_line function should create a new Orange with the name Orange')
    assert_equal(temp.calories, BasicFood.new('Orange', '70').calories, 'The parse_line function should create a new Orange with the name Orange')
  end

end