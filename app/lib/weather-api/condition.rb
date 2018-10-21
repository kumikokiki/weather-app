module WeatherApi
  class Condition
    attr_reader :code,
                :date,
                :temp,
                :text

    def initialize(payload)
      @code = payload[:code]&.strip
      @date = Utils.parse_time payload[:date]
      @temp = payload[:temp]&.to_i
      @text = payload[:text]&.strip
    end
  end
end
