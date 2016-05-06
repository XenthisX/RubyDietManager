# Author: Elijah Bosley
# Class to read the database of food from CSV
require 'csv'
require_relative 'basic_food'
require_relative 'recipe'

class FoodDB


  # function to read the food database and create a new database hash
  def initialize
    food_db = Hash.new(0)
    CSV.foreach('FoodDB.txt') do |row|
      new_food = parse_line(row, food_db)
      food_db[new_food.name] = new_food
    end
    @database = food_db

  end

  attr_reader :database

  # parse the incoming line of CSV
  def parse_line(row, db)
    case row[1]
      when 'b'
        return create_basic_food(row)
      when 'r'
        return create_recipe(row, db)
      else
        puts 'Invalid line in FoodDB.txt'
    end
  end

  # creates a basic food item and returns it to be added to the hash
  def create_basic_food(row)
    BasicFood.new(row[0], row[2])
  end

  # creates a recipe and returns it to be added to the hash
  def create_recipe(row, db)
    name = row[0]
    ingredients= Array.new
    # function to run through row after index

    row[2..-1].each do |item|
      get_food = db[item]
      ingredients.push(get_food)
    end
    Recipe.new(name, ingredients)
  end

  # gets a food item from the database and returns it, if food item isn't present, returns a String, 'Key Not Found!'
  def get_food(food)
    database.fetch(food, 'Key Not Found!')
  end

  # match the prefix of a string to any items in the database
  def prefix_match(prefix)
    val = []
    database.each do |k, v|
      if k.downcase.start_with?(prefix)
        val.push(v)
      end
    end
    if val.size == 0
      val = ['Key Not Found!']
    end
    val
  end

  # add a food given a foodcal CSV string
  def add_food(foodcal)
    food, cal = CSV.parse_line(foodcal)
    puts("#{food}, #{cal}")
    if database.has_key? food
      puts('Food already in Database.')
    else
      database[food] = BasicFood.new(food, cal)
    end
  end

  # add a recipe given a CSV string taken from stdin
  def add_recipe(recipe)
    if database.has_key? recipe[0]
      puts('Recipe already in Database.')
    else
      ingredients_list = []
      recipe[1..-1].each do |ingredient|
        if database.has_key? ingredient
          temp = database[ingredient]
          ingredients_list.push(temp)
        else
          puts('Missing ingredient(s)')
          break
        end
      end
      temp = Recipe.new(recipe[0], ingredients_list)
      database[temp.name] = temp
    end
  end

  # save the database without exiting
  def save
    CSV.open('FoodDB.txt', 'w') do |csv|
      database.each_value do |v|
        csv << v.to_array
      end
    end
  end

  # check if the database contains an item of name: name
  def contains(name)
    database.has_key? name
  end

  # to string function that prints all items in the database using their respective to_s
  def to_s
    out = ''
    database.each_value do |v|
      out+= "#{v}"
    end

    out
  end

end

