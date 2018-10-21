class Location < ApplicationRecord

	belongs_to :forecast, :foreign_key => 'forecast_id'

  validates :city, presence: true


end
