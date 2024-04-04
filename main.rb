# frozen_string_literal: true

require './yearly_weather'
require './monthly_weather'
require './daily_weather'
require 'date'

option = ARGV[0]

case option
when '-e'
  year = ARGV[1]
  files = Dir.glob("#{ARGV[2]}/*").select { |y| y.include?(year) }
  if !files.empty?
    yearly_weather = YearlyWeather.new(files, year)
    yearly_weather.display_data
  else
    puts 'Invalid File'
  end
when '-a'
  year = ARGV[1].split('/')[0]
  month = Date.parse(ARGV[1]).strftime('%b')
  files = Dir.glob("#{ARGV[2]}/*").select { |y| y.include?(year) and y.include?(month) }
  if !files.empty?
    monthly_weather = MonthlyWeather.new(files, month, year)
    monthly_weather.display_data
  else
    puts 'Invalid File'
  end
when '-c'
  year = ARGV[1].split('/')[0]
  month = Date.parse(ARGV[1]).strftime('%b')
  files = Dir.glob("#{ARGV[2]}/*").select { |y| y.include?(year) and y.include?(month) }
  if !files.empty?
    daily_weather = DailyWeather.new(files, year, month)
    daily_weather.display_data_horizontaly
  else
    puts 'Invalid File'
  end
else
  puts 'Invalid Input'
end
