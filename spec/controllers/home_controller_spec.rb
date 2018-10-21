require 'map'
require_relative '../../app/lib/weather-api/response.rb'

RSpec.describe HomeController do
  describe 'GET index' do

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    context 'when has user input' do
      let(:subject) { post :index, params: {forecast: {request_location: 'sydney', temp_unit: 'f'}} }

      before(:each) do
        allow(WeatherApi).to receive_message_chain(:search_by_city_name).and_return(WeatherApi::Response.new 'sydney', 'http://abc.com', Map.new(JSON.parse(File.read("fixtures/api_response.json"))))
      end

      it 'should call api with params' do
        expect(WeatherApi).to receive(:search_by_city_name).with('sydney', 'f')
        subject
      end

      it 'creates forecast, location, weather resources' do
        subject
        expect(Forecast.count).to eq(1)
        expect(Weather.count).to be > 0
        expect(Location.count).to eq(1)
      end

      context 'when has exception from API' do
        before(:each) do
          allow(WeatherApi).to receive(:search_by_city_name).and_raise('error')
        end
        it 'does not create resources' do
          subject
          expect(Forecast.count).to eq(0)
          expect(Weather.count).to eq(0)
          expect(Location.count).to eq(0)
        end
      end
    end

    context 'when no user input' do
      let(:subject) { post :index, params: {} }

      before(:each) do
        allow(WeatherApi).to receive_message_chain(:search_by_city_name).and_return nil
      end

      it 'does not call api' do
        subject
        expect(WeatherApi).not_to receive(:search_by_city_name)
      end
    end
  end
end
