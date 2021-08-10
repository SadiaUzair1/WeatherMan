# frozen_string_literal: true

require 'colorize'
require 'date'
require './task1'
require './Task2'
require './Task3'

# { To check higest lowest and average temperature }
class WeatherMan3
  begin
    Dir.chdir(ARGV[2])
  rescue StandardError
    puts 'invalid input'
  end
  file_name = Dir.entries('.')
  date_and_month = ARGV[1].split('/')
  Task1.max_min(file_name, ARGV[1]) if ARGV[0] == '-e'
  if date_and_month[1].to_i > 12 || date_and_month[1].to_i < 1
    puts 'invalid input '
  else
    Task2.avg_temp(file_name, ARGV[1]) if ARGV[0] == '-a'
    Task3.representation(file_name, ARGV[1]) if ARGV[0] == '-c'
  end
end