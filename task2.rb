# frozen_string_literal: true

module AverageTemp
  def self.avg_temp(file_name, year_month)
    temp_humidity = { 'max' => 0, 'min' => 0, 'humidity' => 0, 'files_count' => 0 }
    year_and_month = year_month.split('/')
    valid_year = false
    file_name.each do |files|
      next unless files.include? year_and_month[0]

      valid_year = true
      month_name = Date::MONTHNAMES[year_and_month[1].to_i]
      month_name = month_name[0..2]
      next unless files.include? month_name

      temp_humidity = read_work_file(files, temp_humidity)
    end
    taking_avg_temp(temp_humidity) if (temp_humidity['files_count']).positive?

    puts 'invalid Input' unless valid_year
  end

  def self.read_work_file(files, temp_humidity)
    to_skip = 0

    IO.foreach(files) do |line|
      if to_skip.zero?
        to_skip += 1
      else
        file_data = line.split(',')
        temp_humidity = sum_temp(file_data, temp_humidity)
      end
    end
    temp_humidity
  end

  def self.sum_temp(file_data, temp_humidity)
    temp_humidity['max'] += file_data[1].to_i
    temp_humidity['min'] += file_data[3].to_i
    temp_humidity['humidity'] += file_data[8].to_i
    temp_humidity['files_count'] += 1
    temp_humidity
  end

  def self.taking_avg_temp(temp_humidity)
    temp_humidity['max'] /= temp_humidity['files_count']
    temp_humidity['min'] /= temp_humidity['files_count']
    temp_humidity['humidity'] /= temp_humidity['files_count']
    print_values(temp_humidity)
  end

  def self.print_values(temp_humidity)
    print "Average Highest: #{temp_humidity['max']}C"
    puts
    print "Average Lowest: #{temp_humidity['min']}C"
    puts
    print "Average Humid: #{temp_humidity['humidity']}% "
    puts
  end
end
