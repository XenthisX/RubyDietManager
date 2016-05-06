require_relative 'recipe'
require 'test/unit'

class TestRecipe < Test::Unit::TestCase

  def test_create_recipe
    recipe = Recipe.new('PB&J Sandwich', [BasicFood.new('Peanut Butter', 175), BasicFood.new('Bread slice', 80), BasicFood.new('Bread slice', 80), BasicFood.new('Jelly', 155)])
    assert_equal(recipe.name, 'PB&J Sandwich', 'The name of the new recipe should be PB&J Sandwich')
  end

  def test_get_calories
    recipe = Recipe.new('PB&J Sandwich', [BasicFood.new('Peanut Butter', 175), BasicFood.new('Bread slice', 80), BasicFood.new('Bread slice', 80), BasicFood.new('Jelly', 155)])
    assert_equal(recipe.calories, 490, 'Total calories for the recipe should be 490')
  end

  def test_to_s
    recipe = Recipe.new('PB&J Sandwich', [BasicFood.new('Peanut Butter', 175), BasicFood.new('Bread slice', 80), BasicFood.new('Bread slice', 80), BasicFood.new('Jelly', 155)])
    assert_equal(recipe.to_s, "PB&J Sandwich 490\n  Peanut Butter  175\n  Bread slice  80\n  Bread slice  80\n  Jelly  155\n", 'to_s output should equal given to_s')
  end

end