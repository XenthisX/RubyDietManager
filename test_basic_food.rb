require_relative 'basic_food'
require 'test/unit'

class TestBasicFood < Test::Unit::TestCase

  def test_create_food
    food =  BasicFood.new('Carrot', 150)
    assert_equal(food.to_s, "Carrot  150\n", "Output after creating a new carrot object should be 'Carrot  150'")
  end

  def test_get_calories
    food = BasicFood.new('Orange', 79)
    assert_equal(food.get_calories, 79, 'The new Orange object should have a calorie count of 79')
  end

end