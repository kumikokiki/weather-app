module WeatherApi
  class Wind
    attr_reader :chill,
                :direction,
                :speed

    def initialize(payload)
      @chill = payload[:chill]&.to_i
      @direction = payload[:direction]&.to_i
      @speed = payload[:speed]&.to_i
    end
  end
end
