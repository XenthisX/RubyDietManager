# Author: Elijah Bosley
# main function responsible for running the command line for Diet Manager

require_relative 'food_db'
require_relative 'basic_food'
require_relative 'log'



class String
  def is_i?
    /\A[-+]?\d+\z/ === self
  end
end

db = FoodDB.new
log = Log.new
changed = false

# Process each line given through stdin, much of this code is partially borrowed from GeoCalc
$stdin.each do |line|
  command = line.strip.split(' ')

  case command[0]
    when 'print'
      name = command[1..-1].join(' ')
      if command[1] == 'all'
        puts(db)
      else
        puts db.get_food(name)
      end

    when 'quit'
      if changed
        db.save
      end
      log.save
      exit(0)

    when 'find'
      name = command[1..-1].join(' ')
      puts db.prefix_match(name.downcase)

    when 'new'
      if command[1] == 'food'
        if command.length > 3
          food_name = command[2..-2].join(' ') # first join the 3 in the middle
          end_csv = CSV.parse_line(command[-1]) # parses the last character as a string, integer pair
          if end_csv[1].is_i? && end_csv.size == 2
            food_name += ' ' + end_csv[0]
            food_cal = end_csv[1]
            csv_food_cal = [food_name, food_cal].to_csv
            db.add_food(csv_food_cal)
            changed = true
          else
            puts('Error, Incorrectly Formatted Input')
            break
          end
        else
          db.add_food(command[2])
          changed = true
        end
      elsif command[1] == 'recipe'
        full_string = line.strip.split(',')
        # need to remove 'new recipe' from the full_string parameter
        front = full_string[0].split(' ')
        new_front = front[2..-1].join(' ')
        full_string[0] = new_front
        db.add_recipe(full_string)
        changed = true
      else
        puts('Invalid item')
      end

    when 'save'
      db.save
      log.save

    when 'log'
      # This disgusting block of code deals with the fact that the commands are split at first, and must account for
      # spacing. I know it's ugly but it's the best solution I could come up with for dealing with the numerous
      # different ways that a command for log could be put in. It is fairly straightforward, at least to me, but it's
      # not pretty at all
      food_name = command[1..-2].join(' ') # first join the 3 in the middle
      end_csv = CSV.parse_line(command[-1]) # parses the last character as a string, integer pair
      if end_csv.size > 1 # it has a date attached
        if end_csv.size == 2 # makes sure it has a date attached
          food_name += ' ' + end_csv[0]
          date_string = end_csv[1]
          date = Date.strptime(date_string, '%m/%d/%Y')
        else
          puts ('Invalid Command')
        end
      elsif end_csv.size == 1 && food_name != '' # 2 cases, one in case there is a one word log item to add
        food_name += ' ' + end_csv[0]
      elsif end_csv.size == 1
        food_name += end_csv[0]
      else
        puts('Invalid Command')
      end

      if db.contains(food_name) # make sure database has item attempting to log
        if date == nil
          log.add_basic(food_name)
        else
          log.add(food_name, date)
        end
      else
        puts('Invalid food')
      end

    when 'show'
      if command.size == 1
        date = Date.today
        puts(log.show(date))
      elsif command[1] == 'all'
        puts(log)
      elsif command.size == 2
        date = Date.strptime(command[1], '%m/%d/%Y')
        puts(log.show(date))


      end

    when 'delete'
      food_name = command[1..-2].join(' ') # first join the 3 in the middle
      end_csv = CSV.parse_line(command[-1]) # parses the last character as a string, integer pair
      if end_csv.size > 1 # it has a date attached
        if end_csv.size == 2 # makes sure it has a date attached
          food_name += ' ' + end_csv[0]
          date_string = end_csv[1]
          date = Date.strptime(date_string, '%m/%d/%Y')
        else
          puts ('Invalid Command')
        end
      elsif end_csv.size == 1 && food_name != '' # 2 cases, one in case there is a one word log item to add
        food_name += ' ' + end_csv[0]
      elsif end_csv.size == 1
        food_name += end_csv[0]
      else
        puts('Invalid Command')
      end

      log.delete(food_name,date)

    else
      puts 'Invalid Command'

  end
end

