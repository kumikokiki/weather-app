class Forecast < ApplicationRecord
  has_many :weather, dependent: :destroy
  has_one  :location, dependent: :destroy

  validates :request_location,
            :current_weather_code,
            :date_time,
            :current_temperature,
            :temperature_unit,
            :current_weather_text, presence: true

  attr_accessor :temp_unit

end
