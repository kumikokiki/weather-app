class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.references :forecast, index: true
      t.string :city, null: false
      t.string :region
      t.string :country
      t.timestamps null: false
    end
  end
end
