require 'net/http'
require 'json'
require 'map'
require "erb"

require 'weather-api/astronomy'
require 'weather-api/atmosphere'
require 'weather-api/condition'
require 'weather-api/forecast'
require 'weather-api/location'
require 'weather-api/response'
require 'weather-api/units'
require 'weather-api/utils'
require 'weather-api/wind'
require 'weather-api/error.rb'


module WeatherApi
  class << self
    VALID_TEMP_UNITS = [Units::CELSIUS, Units::FAHRENHEIT].freeze

    # https://developer.yahoo.com/weather/

    API_ENDPOINT = ENV['YAHOO_WEATHER_API_ENDPOINT'].freeze

    def search_by_woeid(woeid, unit = Units::CELSIUS)
      get_response(unit, "?q=select * from weather.forecast where woeid='#{woeid}' and u='#{unit}'&format=json", woeid)

    end


    def search_by_city_name(city_name, unit = Units::CELSIUS)
      get_response(unit,
                   "?q=select * from weather.forecast where woeid in (select woeid from geo.places(1) where text='#{city_name}') and u='#{unit}'&format=json",
                   city_name)
    end

    private

    def get url
      uri = URI.parse url
      res = Net::HTTP.get_response(uri)
      response = res.body.to_s
      response = Map.new(JSON.parse(response))[:query][:results][:channel]
      if response.nil? || res.code != '200'
        raise Error.new("500"), "Failed to get weather [url=#{url}]."
      end
      response
    rescue => e
      raise Error.new("500"), "Failed to get weather [url=#{url}, e=#{e}]."
    end

    def valid_unit(unit)
      unless VALID_TEMP_UNITS.include?(unit)
        raise Error.new("400"), "Invalid temperature unit"
      end
    end

    def get_response(unit, query, location)
      valid_unit(unit)
      url = API_ENDPOINT + URI.escape(query)
      doc = get url
      Response.new location, url, doc
    end
  end
end
