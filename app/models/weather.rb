class Weather < ApplicationRecord
  self.table_name = 'weather'
  belongs_to :forecast, :foreign_key => 'forecast_id'
  validates :high_temperature,
            :low_temperature,
            :weather_code,
            :date,
            :weather_text, presence: true
  delegate :temperature_unit, to: :forecast
end
