# frozen_string_literal: true

require 'colorize'
require 'date'
# class to get daily weather details
class DailyWeather
  def initialize(files, year, month)
    @year = year
    @files = files
    @month = month
    @date_pair = {}
  end

  def fetch_daily_data # rubocop:todo Metrics/AbcSize
    @files.each do |file|
      File.readlines(file).each do |line|
        next unless line.include?(@year) && line.split(',')[1].to_i != 0

        @date_pair[line.split(',')[0].split('-')[2]] = [line.split(',')[1].to_i, line.split(',')[3].to_i]
      end
    end
  end

  def display_data # rubocop:todo Metrics/AbcSize
    fetch_daily_data
    puts "#{Date.parse(@month).strftime('%B')} #{@year}"
    @date_pair.each do |date, temp|
      print date
      temp[0].times { print '+'.red }
      puts "#{temp[0]}C"
      print date
      temp[1].times { print '+'.blue }
      puts "#{temp[1]}C"
    end
  end

  def display_data_horizontaly # rubocop:todo Metrics/AbcSize
    fetch_daily_data
    puts "#{Date.parse(@month).strftime('%B')} #{@year}"
    @date_pair.each do |date, temp|
      print date
      temp[0].times { print '+'.red }
      temp[1].times { print '+'.blue }
      puts " #{temp[0]}C - #{temp[1]}C"
    end
  end
end
