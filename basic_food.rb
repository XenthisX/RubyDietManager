# Author: Elijah Bosley
# Basic Food class responsible for dealing with basic foods
class BasicFood

  # Methods below are private
  private

  def initialize(name, calories)
    @name = name
    @calories = calories
  end

  # Methods below are public
  public

  # Allows access to the name and calorie count of the BasicFood
  attr_reader :name, :calories

  def get_calories
    calories
  end

  def to_s
    "#{name}  #{calories}\n"
  end

  def to_array
    temp = [name, 'b', calories]
    temp
  end

end