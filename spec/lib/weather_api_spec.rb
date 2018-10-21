require_relative '../../app/lib/weather_api.rb'

RSpec.describe WeatherApi do
  context ".search_by_woeid" do
    let(:woeid) { '1105779' } # Sydney
    let(:unit) { WeatherApi::Units::CELSIUS }
    let(:subject) { WeatherApi.search_by_woeid(woeid, unit) }


    it "gets sydney in the response title" do
      expect(subject.title.downcase).to include('sydney')
    end

    it "gets sydney in the response city" do
      expect(subject.location.city.downcase).to eq('sydney')
    end

    it "gets c for the temperature unit" do
      expect(subject.units.temperature.downcase).to eq('c')
    end

    it "gets forecasts data" do
      expect(subject.forecasts.size).to be > 1
    end
  end


  context ".search_by_city_name" do
    let(:city_name) { 'Melbourne' }
    let(:unit) {  WeatherApi::Units::FAHRENHEIT }
    let(:subject) { WeatherApi.search_by_city_name(city_name, unit) }

    it "gets melbourne in the response title" do
      expect(subject.title.downcase).to include('melbourne')
    end

    it "gets melbourne in the response city" do
      expect(subject.location.city.downcase).to eq('melbourne')
    end

    it "gets f for the temperature unit" do
      expect(subject.units.temperature.downcase).to eq('f')
    end

    it "gets forecasts data" do
      expect(subject.forecasts.size).to be > 1
    end
  end

  context "send valid_unit method" do
    context "valid unit" do
      let(:valid_unit) { WeatherApi::Units::FAHRENHEIT  }
      let(:subject) { WeatherApi.send(:valid_unit, valid_unit) }
      it "does not raise exception" do
        expect{subject}.not_to raise_error(WeatherApi::Error)
      end
    end

    context "invalid unit" do
      let(:invalid_unit) { 'invalid unit' }
      let(:subject) { WeatherApi.send(:valid_unit, invalid_unit) }
      it "raises Weather Error msg" do
        expect{subject}.to raise_error(WeatherApi::Error, "Invalid temperature unit")
      end

      it "raises Weather Error code 400" do
        begin
          subject
        rescue => ex
          expect(ex.status_code).to eq('400')
        end
      end
    end
  end
end
