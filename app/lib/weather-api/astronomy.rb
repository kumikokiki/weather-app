module WeatherApi
  class Astronomy
    attr_reader :sunrise,
                :sunset

    def initialize(payload)
      @sunrise = Utils.parse_time payload[:sunrise]
      @sunset = Utils.parse_time payload[:sunset]
    end
  end
end
