#Author: Elijah Bosley
# Class to hold log items, which are stored with a date and a food
# Log Items are stored in lists when the next one is added
class LogItem

  private

  def initialize(name, date)
    names = Hash.new(0)
    names[name] = 1
    @names = names
    @date = date
  end

  public

  attr_reader :names, :date

  # adds an item to the list of items on a date
  def add_item(new_item)
    names[new_item] += 1
  end

  # removes an item from the LogItem
  def remove_item(name)
    puts("Removing #{name} #{names.has_key? name}")
    if names.has_key? name
      if names[name] > 1
        names[name] -= 1
      elsif names.size >= 1
        names.delete(name)
      end

    end

  end

  # converts from date form to original form for the save function
  def to_output
    temp = ''
    names.each do |k, v|
      v.times { temp += "#{date.strftime('%-m/%-d/%Y')},#{k}\n" }
    end
    temp
  end

  # returns true if empty
  def empty
    names.size == 0
  end

  def to_s
    out = "#{date.strftime('%m/%d/%Y')}\n"
    names.each do |k, v|
      if v > 1
        out += "#{k} (#{v})\n"
      else
        out += "#{k}\n"
      end

    end
    out
  end

end