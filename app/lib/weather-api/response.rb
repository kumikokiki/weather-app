module WeatherApi
  class Response
    attr_reader :request_location,
                :request_url,
                :astronomy,
                :location,
                :units,
                :wind,
                :atmosphere,
                :forecasts,
                :condition,
                :latitude,
                :longitude,
                :title,
                :description

    def initialize(request_location, request_url, doc)
      @request_location = request_location
      @request_url      = request_url
      @forecasts = []
      @astronomy  = Astronomy.new doc[:astronomy]
      @location   = Location.new doc[:location]
      @units      = Units.new doc[:units]
      @wind       = Wind.new doc[:wind]
      @atmosphere = Atmosphere.new doc[:atmosphere]
      @condition  = Condition.new doc[:item][:condition]

      doc[:item][:forecast].each do |forecast|
        @forecasts << Forecast.new(forecast)
      end

      @latitude    = doc[:item][:lat].to_f
      @longitude   = doc[:item][:long].to_f
      @title       = doc[:item][:title]&.strip
      @description = doc[:item][:description]&.strip
    end
  end
end
