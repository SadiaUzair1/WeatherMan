# frozen_string_literal: true

# {to get average highest,lowest temperature and humidity}
module Task2
  def self.fixed_array(size, other)
    Array.new(size) { |i| other[i] }
  end

  def self.print_values(min_max_count_temp_humidity)
    print "Average Highest: #{min_max_count_temp_humidity[0]}C"
    puts
    print "Average Lowest: #{min_max_count_temp_humidity[1]}C"
    puts
    print "Average Humid: #{min_max_count_temp_humidity[2]}% "
    puts
  end

  def self.add_temp(file_data, min_max_count_temp_humidity)
    min_max_count_temp_humidity[0] += file_data[1].to_i
    min_max_count_temp_humidity[1] += file_data[3].to_i
    min_max_count_temp_humidity[2] += file_data[8].to_i
    min_max_count_temp_humidity[3] += 1
    min_max_count_temp_humidity
  end

  def self.read_work_file(files, min_max_count_temp_humidity)
    first_iteration_to_skip_from_checking_temperature = 0

    # {to read file contents}
    IO.foreach(files) do |line|
      # {to skip first line of file}
      if first_iteration_to_skip_from_checking_temperature.zero?
        first_iteration_to_skip_from_checking_temperature += 1
      else
        file_data = line.split(',')
        # {finding highest temperature}
        min_max_count_temp_humidity = add_temp(file_data, min_max_count_temp_humidity)
      end
    end
    min_max_count_temp_humidity
  end

  def self.taking_avg_temp(min_max_count_temp_humidity)
    min_max_count_temp_humidity[0] /= min_max_count_temp_humidity[3]
    min_max_count_temp_humidity[1] /= min_max_count_temp_humidity[3]
    min_max_count_temp_humidity[2] /= min_max_count_temp_humidity[3]
    print_values(min_max_count_temp_humidity)
  end

  def self.working_avg_temp(file_name, year_month)
    min_max_count_temp_humidity = fixed_array(4, [0, 0, 0, 0])

    year_and_month = year_month.split('/')
    # {getting files from required directory}
    file_name.each do |files|
      next unless files.include? year_and_month[0]

      month_name = Date::MONTHNAMES[year_and_month[1].to_i]
      month_name = month_name[0..2]
      next unless files.include? month_name

      min_max_count_temp_humidity = read_work_file(files, min_max_count_temp_humidity)
    end
    taking_avg_temp(min_max_count_temp_humidity)
  end

  def self.avg_temp(file_name, year_month)
    working_avg_temp(file_name, year_month)
  end
end
