require_relative '../lib/weather_api.rb'
class HomeController < ApplicationController
  layout 'application'

  def index
    @forecast = Forecast.new
    begin
      if weather_feed_params[:request_location].present? && weather_feed_params[:temp_unit].present?
        @weather_feed ||= weather_feed(weather_feed_params[:request_location], weather_feed_params[:temp_unit])
      end
      if @weather_feed.present?
        store_records(@weather_feed)
      end
    rescue => ex
      Rails.logger.error(ex)
    end
  end

  private

  def weather_feed(city, unit)
    WeatherApi.search_by_city_name(city,unit)
  end

  def weather_feed_params
    keys = [
      :request_location,
      :temp_unit
    ]

    extra = {
      request_location: params.dig(:forecast,:request_location).presence,
      temp_unit: params.dig(:forecast,:temp_unit).presence,
    }

    params
      .merge(extra)
      .slice(*keys)
      .permit(*keys)
  end

  def store_records(res)
    ActiveRecord::Base.transaction do
      begin
        f = Forecast.create!(request_location: weather_feed_params[:request_location],
                             current_weather_code: res.condition.code,
                             date_time: res.condition.date,
                             current_temperature: res.condition.temp,
                             temperature_unit: res.units.temperature,
                             current_weather_text: res.condition.text)

        Location.create!(forecast: f,
                         city: res.location.city,
                         region: res.location.region,
                         country: res.location.country)

        res.forecasts.each do |fc|
          Weather.create!(forecast: f,
                          high_temperature: fc.high,
                          low_temperature: fc.low,
                          weather_code: fc.code,
                          date: fc.date,
                          weather_text: fc.text)
        end
      rescue => e
        Rails.logger.error(e)
        raise ActiveRecord::Rollback
      end
    end
  end
end
