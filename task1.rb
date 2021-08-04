# frozen_string_literal: true

# {to get highest,lowest temperature and humidity}
module Task1
  def self.max_min(file_name, year)
    # {declaring variables}
    max_temperature = 0
    min_temperature = 1_000_000
    max_temperature_date = ''
    min_temperature_date = ''
    max_humidity = 0
    max_humid_date = ''
    check_whether_given_year_is_in_file_or_not = 0

    # {getting files from required directory}
    file_name.each do |files|
      next unless files.include? year

      check_whether_given_year_is_in_file_or_not += 1
      first_iteration_to_skip_from_checking_temperature = 0
      # {to read file contents}
      IO.foreach(files) do |line|
        # {to skip first line of file}
        if first_iteration_to_skip_from_checking_temperature.zero?
          first_iteration_to_skip_from_checking_temperature += 1
        else
          file_data = line.split(',')
          # {finding highest temperature}
          if max_temperature < file_data[1].to_i
            max_temperature = file_data[1].to_i
            max_temperature_date = file_data[0]
          end
          # {finding lowest tempereature}
          if min_temperature > file_data[3].to_i
            min_temperature = file_data[3].to_i
            min_temperature_date = file_data[0]
          end
          # {finding max humidity}
          if max_humidity < file_data[8].to_i
            max_humidity = file_data[8].to_i
            max_humid_date = file_data[0]
          end
        end
      end
    end
    if check_whether_given_year_is_in_file_or_not != 0
      max_temperature_date = max_temperature_date.split('-')
      min_temperature_date = min_temperature_date.split('-')
      max_humid_date = max_humid_date.split('-')
      month_name = Date::MONTHNAMES[max_temperature_date[1].to_i]
      print "Highest: #{max_temperature}C on #{month_name} #{max_temperature_date[2]}"
      puts
      month_name = Date::MONTHNAMES[min_temperature_date[1].to_i]
      print "Lowest: #{min_temperature}C on #{month_name} #{min_temperature_date[2]}"
      puts
      month_name = Date::MONTHNAMES[min_temperature_date[1].to_i]
      print "Humid: #{max_humidity}% on #{month_name} #{max_humid_date[2]}"
      puts
    else
      puts 'No files found'
    end
  end
end
