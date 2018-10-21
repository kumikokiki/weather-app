module WeatherApi
  class Units
    FAHRENHEIT = 'f'
    CELSIUS   = 'c'
    attr_reader :temperature,
                :distance,
                :pressure,
                :speed

    def initialize(payload)
      @temperature = payload[:temperature]&.strip
      @distance = payload[:distance]&.strip
      @pressure = payload[:pressure]&.strip
      @speed = payload[:speed]&.strip
    end
  end
end
