module WeatherApi
  class Location
    attr_reader :city,
                :region,
                :country

    def initialize(payload)
      @city = payload[:city]&.strip
      @region = payload[:region]&.strip
      @country = payload[:country]&.strip
    end
  end
end
