require 'chronic'
module WeatherApi
  class Utils
    def self.parse_time(text = '')
      if text == ''
        return nil
      end

      begin
        Time.parse text
      rescue ArgumentError
        Chronic.parse text
      end
    end
  end
end
