# frozen_string_literal: true

require 'date'
# class to get yearly data
class YearlyWeather
  def initialize(files, year)
    @files = files
    @year = year
    @highest_temp = []
    @lowest_temp = []
    @most_humid = []
    @dates = []
  end

  def fetch_yearly_data # rubocop:todo Metrics/AbcSize
    @files.each do |file|
      File.readlines(file).each do |line|
        next unless line.include?(@year) && line.split(',')[1].to_i != 0

        @dates << line.split(',')[0]
        @highest_temp << line.split(',')[1].to_i
        @lowest_temp << line.split(',')[3].to_i
        @most_humid << line.split(',')[7].to_i
      end
    end
  end

  def fetch_max_temp
    max_temp = @highest_temp.max
    date = @dates[@highest_temp.index(max_temp)]
    [max_temp, date]
  end

  def fetch_min_temp
    min_temp = @lowest_temp.min
    date = @dates[@lowest_temp.index(min_temp)]
    [min_temp, date]
  end

  def fetch_max_humid
    max_humid = @most_humid.max
    date = @dates[@most_humid.index(max_humid)]
    [max_humid, date]
  end

  def date_transform(date)
    month = Date.parse(date[1]).strftime('%B')
    day = date[1].split('-')[2]
    "#{month} #{day}"
  end

  def display_data # rubocop:todo Metrics/AbcSize
    fetch_yearly_data
    date_transform(fetch_max_temp)
    date_transform(fetch_min_temp)
    date_transform(fetch_max_humid)
    puts "Highest: #{fetch_max_temp[0]}C on #{date_transform(fetch_max_temp)}"
    puts "Lowest: #{fetch_min_temp[0]}C on #{date_transform(fetch_min_temp)}"
    puts "Humid: #{fetch_max_humid[0]}% on #{date_transform(fetch_max_humid)}"
  end
end
