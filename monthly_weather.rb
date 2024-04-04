# frozen_string_literal: true

# class to get monthly weather information
class MonthlyWeather
  def initialize(files, month, year)
    @year = year
    @month = month
    @files = files
    @highest_avg = 0
    @lowest_avg = 0
    @avg_humidity = 0
    @high_temp = []
    @low_temp = []
    @humidity = []
  end

  def fetch_weather_data
    @files.each do |file|
      File.readlines(file).each do |line|
        next unless line.include?(@year) && line.split(',')[1].to_i != 0

        @high_temp << line.split(',')[1]
        @low_temp << line.split(',')[3]
        @humidity << line.split(',')[8]
      end
    end
  end

  def calculate_highest_avg
    highest_temp = @high_temp.compact.map(&:to_i)
    @highest_avg = highest_temp.inject(:+)./(highest_temp.length)
  end

  def calculate_lowest_avg
    lowest_temp = @low_temp.compact.map(&:to_i)
    @lowest_avg = lowest_temp.inject(:+)./(lowest_temp.length)
  end

  def calculate_avg_humidity
    humid = @humidity.compact.map(&:to_i)
    @avg_humidity = humid.inject(:+)./(humid.length)
  end

  def display_data
    fetch_weather_data
    calculate_highest_avg
    calculate_avg_humidity
    calculate_lowest_avg
    puts("Highest Average: #{@highest_avg}C")
    puts("Lowest Average: #{@lowest_avg}C")
    puts("Average Humidity: #{@avg_humidity}%")
  end
end
