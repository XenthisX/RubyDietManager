# Author: Elijah Bosley
# Class to manage the log
require 'date'
require 'csv'
require_relative 'log_item'

class Log
  def initialize
    log = Hash.new('No entries on this date!')
    @log = log
    CSV.foreach('DietLog.txt') do |row|
      parse_line(row)
    end
  end

  attr_reader :log

  # function to add to the database given a food and a date
  def add(food, date)
    if log.has_key? date
      log[date].add_item(food)
    else
      temp = LogItem.new(food, date)
      log[date] = temp
    end
  end

  # parses the line and adds the row to the database
  def parse_line(row)
    date_str = row[0]
    food = row[1]
    date = Date.strptime(date_str, '%m/%d/%Y')
    add(food, date)
  end

  # adds an entry using today's date if called
  def add_basic(name)
    date = Date.today

    add(name, date)
  end

  # save the log without exiting
  def save
    output = ''
    log.each_value do |v|
      output += v.to_output
    end
    File.open('DietLog.txt', 'w') {|f| f.write(output)}
  end

  # returns the item at the given date
  def show(date)
    return log[date]
  end

  # deletes the item from the log_item, then deletes the date from the log if the entry is empty
  def delete(name, date)
    puts("#{name}, #{date}")
    log[date].remove_item(name)
    if log[date].empty
      log.delete(date)
    end
  end

  # to string
  def to_s
    sorted = Hash[log.sort_by { |date, _| date }]
    out = ''
    sorted.each_value do |v|
      out += "#{v}"
    end
    out
  end


end