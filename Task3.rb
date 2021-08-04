require 'colorize'
require 'date'

# {to represent highest,lowest temperature }
module Task3
  def self.draw_high_temp(file_data, day)
    j = 1
    print day
    while j < file_data[1].to_i
      print '+'.red
      j += 1
    end
    print " #{file_data[1]}C"
  end

  def self.min_high_temp(file_data, day)
    j = 1
    puts
    print day
    while j < file_data[3].to_i
      print '+'.blue
      j += 1
    end
    print " #{file_data[3]}C"
    puts
  end

  def self.draw_temps(line, day)
    file_data = line.split(',')
    draw_high_temp(file_data, day)
    min_high_temp(file_data, day)

  end

  def self.max_min_temp(files)
    first_iteration_to_skip_from_checking_temperature = 0
    # {to read file contents}'
    i = 1
    IO.foreach(files) do |line|
      # {to skip first line of file}
      if first_iteration_to_skip_from_checking_temperature.zero?
        first_iteration_to_skip_from_checking_temperature = 1
      else
        draw_temps(line, i)
        i += 1
      end
    end
  end

  def self.representation(file_name, year)
    year_and_month = year.split('/')
    # {getting files from required directory}
    file_name.each do |files|
      next unless files.include? year_and_month[0]

      month_name = Date::MONTHNAMES[year_and_month[1].to_i]
      month_name = month_name[0..2]
      next unless files.include? month_name

      max_min_temp(files)
    end
  end
end
