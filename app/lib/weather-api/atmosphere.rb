module WeatherApi
	class Atmosphere
		# https://developer.yahoo.com/weather/documentation.html
		Barometer = { '0' => 'steady',
									'1' => 'rising',
									'2' => 'falling' }

		attr_reader :humidity,
								:visibility,
								:pressure,
								:barometer

		def initialize(payload)
			@humidity   = payload[:humidity]&.to_i
			@visibility = payload[:visibility]&.to_i
			@pressure   = payload[:pressure]&.to_f
			@barometer = Barometer[payload[:rising]]
		end
	end
end
