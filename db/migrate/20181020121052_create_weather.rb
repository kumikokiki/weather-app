class CreateWeather < ActiveRecord::Migration[5.0]
  def change
    create_table :weather do |t|
      t.references :forecast, index: true
      t.string :weather_code, null: false
      t.datetime :date, null: false
      t.integer :high_temperature, null: false
      t.integer :low_temperature, null: false
      t.string :weather_text, null: false
      t.timestamps null: false
    end
  end
end
