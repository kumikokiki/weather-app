require 'rails_helper'

feature "Weather app home page" do
  background do
    visit '/'
  end

  scenario "user accesses the page without any input" do
    expect(page).to have_selector("#forecast_request_location", :text => "Sydney")
    expect(page).to have_selector("#forecast_temp_unit", :text => "CELSIUS")
    expect(page).to have_no_css('table')
    expect(page).to have_no_content("Temperature")
  end

  scenario "user chooses sydney location and CELSIUS temp unit" do
    VCR.use_cassette('weather/sydney') do
      select('Sydney', :from => 'forecast_request_location')
      select('CELSIUS', :from => 'forecast_temp_unit')
      click_on('Refresh')
      expect(page).to have_css('table')
      expect(page).to have_content("Conditions for Sydney")
      expect(page).to have_content("°C")
      expect(page).to have_no_content("°F")
      expect(page).to have_content("Temperature")
    end
  end

  scenario "user chooses melbourne location and FAHRENHEIT temp unit" do
    VCR.use_cassette('weather/melbourne') do
      select('Melbourne', :from => 'forecast_request_location')
      select('FAHRENHEIT', :from => 'forecast_temp_unit')
      click_on('Refresh')
      expect(page).to have_css('table')
      expect(page).to have_content("Conditions for Melbourne,")
      expect(page).to have_content("°F")
      expect(page).to have_no_content("°C")
      expect(page).to have_content("Temperature")
    end
  end
end
