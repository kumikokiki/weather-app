module WeatherApi
  class Forecast
    attr_reader :day,
                :date,
                :low,
                :high,
                :text,
                :code

    def initialize(payload)
      @day  = payload[:day].strip
      @date = Utils.parse_time payload[:date]
      @low  = payload[:low]&.to_i
      @high = payload[:high]&.to_i
      @text = payload[:text]
      @code = payload[:code]&.strip
    end
  end
end
