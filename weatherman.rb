# frozen_string_literal: true

require 'colorize'
require 'date'
require './task1'
require './task2'
require './task3'

class WeatherMan
  begin
    Dir.chdir(ARGV[2])
  rescue StandardError
    puts 'invalid input'
  end
  file_name = Dir.entries('.')
  date_and_month = ARGV[1].split('/')
  ExtremeTemps.max_min(file_name, ARGV[1]) if ARGV[0] == '-e'
  if ARGV[0] != '-e' && (date_and_month[1].to_i > 12 || date_and_month[1].to_i < 1)
    puts 'invalid input '
  else
    AverageTemp.avg_temp(file_name, ARGV[1]) if ARGV[0] == '-a'
    RepresentTemp.representation(file_name, ARGV[1]) if ARGV[0] == '-c'
  end
end
