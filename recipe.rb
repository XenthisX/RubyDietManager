# Author: Elijah Bosley
# Recipe class responsible for dealing with recipes
require_relative 'food_db'
require_relative 'basic_food'
require 'set'

class Recipe

  # Methods below are private
  private

  def initialize(name, ingredients)
    @name = name
    @ingredients = ingredients
    @calories = get_calories

  end

  # Methods below are public
  public

  attr_reader :name, :ingredients, :calories


  # returns an integer representation of the calories for a recipe
  def get_calories
    total_cal = 0
    @ingredients.each do |x|
      total_cal += x.get_calories.to_i
    end
    total_cal
  end

  # to string, recursively calls to_s on other items in ingredients list
  def to_s
    different_ingredients = Hash.new(0)
    ingredients.each do |ingredient|
      different_ingredients[ingredient] += 1
    end
    out = "#{name} #{get_calories}\n"
    different_ingredients.each do |ingredient, times|
      if times > 1
        out += "  (#{times}) #{ingredient.to_s}"
      else
        out += "  #{ingredient}"
      end
    end
    out
  end

  # converts recipe to array
  def to_array
    temp = []
    ingredients.each do |ingredient|
      temp.push(ingredient.name)
    end
    temp.insert(0, 'r')
    temp.insert(0, name)
    temp
  end

end