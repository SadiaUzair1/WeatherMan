# frozen_string_literal: true

# {to get highest,lowest temperature and humidity}
module Task1
  def self.max_min(file_name, year)
    # {declaring variables}
    temp_humidity = { 'max' => 0, 'min' => 1_000_000, 'min_date' => '', 'max_date' => '', 'humidity' => 0,
                      'humidity_date' => '' }

    valid_year = false
    # {getting files from required directory}
    file_name.each do |files|
      next unless files.include? year

      valid_year = true
      to_skip = 0
      # {to read file contents}
      IO.foreach(files) do |line|
        # {to skip first line of file}
        if to_skip.zero?
          to_skip += 1
        else
          file_data = line.split(',')
          temp_humidity = cal_temp(temp_humidity, file_data)
        end
      end
    end
    if valid_year
      print_values(temp_humidity)
    else
      puts 'Invalid Input'
    end
  end

  def self.cal_temp(temp_humidity, file_data)
    # {finding highest temperature}

    if temp_humidity['max'] < file_data[1].to_i
      temp_humidity['max'] = file_data[1].to_i
      temp_humidity['max_date'] = file_data[0]
    end
    # {finding lowest tempereature}
    if temp_humidity['min'] > file_data[3].to_i
      temp_humidity['min'] = file_data[3].to_i
      temp_humidity['min_date'] = file_data[0]
    end
    # {finding max humidity}
    if temp_humidity['humidity'] < file_data[8].to_i
      temp_humidity['humidity'] = file_data[8].to_i
      temp_humidity['humidity_date'] = file_data[0]
    end
    temp_humidity
  end

  def self.print_values(temp_humidity)
    temp_humidity = seperate_temp(temp_humidity)
    puts "Highest: #{temp_humidity['max'].to_i}C on #{Date::MONTHNAMES[temp_humidity['max_date'][1].to_i]} #{temp_humidity['max_date'][2].to_i}"
    puts "Lowest: #{temp_humidity['min'].to_i}C on #{Date::MONTHNAMES[temp_humidity['min_date'][1].to_i]} #{temp_humidity['min_date'][2].to_i}"
    puts "Humid: #{temp_humidity['humidity'].to_i}% on #{Date::MONTHNAMES[temp_humidity['humidity_date'][1].to_i]} #{temp_humidity['humidity_date'][2].to_i}"
  end

  def self.seperate_temp(temp_humidity)
    temp_humidity['max_date'] = temp_humidity['max_date'].split('-')
    temp_humidity['min_date'] = temp_humidity['min_date'].split('-')
    temp_humidity['humidity_date'] = temp_humidity['humidity_date'].split('-')
    temp_humidity
  end
end
