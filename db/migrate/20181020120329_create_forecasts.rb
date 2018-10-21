class CreateForecasts < ActiveRecord::Migration[5.0]
  def change
    create_table :forecasts do |t|
      t.string :request_location, null: false
      t.string :current_weather_code, null: false
      t.datetime :date_time, null: false
      t.integer :current_temperature, null: false
      t.string :current_weather_text, null: false
      t.string :temperature_unit, null: false
      t.timestamps null: false
    end
  end
end
