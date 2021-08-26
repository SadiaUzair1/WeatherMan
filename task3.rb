# frozen_string_literal: true

require 'colorize'
require 'date'
module RepresentTemp
  def self.representation(file_name, year)
    year_and_month = year.split('/')
    valid_year = false
    # {getting files from required directory}
    file_name.each do |files|
      next unless files.include? year_and_month[0]

      valid_year = true
      month_name = Date::MONTHNAMES[year_and_month[1].to_i]
      month_name = month_name[0..2]
      next unless files.include? month_name

      max_min_temp(files)
    end
    puts 'Invalid input' unless valid_year
  end

  def self.max_min_temp(files)
    to_skip = true
    i = 1
    IO.foreach(files) do |line|
      if to_skip
        to_skip = false
      else
        temperature(line, i)
        i += 1
      end
    end
  end

  def self.temperature(line, day)
    file_data = line.split(',')
    draw_temp(file_data, day, 1)
    puts
    draw_temp(file_data, day, 3)
    puts
  end

  def self.draw_temp(file_data, day, index)
    j = 1
    print day
    while j < file_data[index].to_i
      if index == 1
        print '+'.red
      else
        print '+'.blue
      end
      j += 1
    end
    print " #{file_data[index]}C"
  end
end
