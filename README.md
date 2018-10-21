# README
Weather App is based on Yahoo Weather by choose your city name and temperature unit(CELSIUS or FAHRENHEIT)from select list. The web page will display weather details like temperature, weather description, wind, humidity, pressure and forecasts.


* Ruby version
  * ruby 2.4

* System dependencies
  * bundler

* Initial setup
    ```
    bundle install
    rake db:create
    rake db:migrate
    ```
* How to run the test suite
    ```
    rake db:migrate RAILS_ENV=test
    bundle exec rspec
    ```
The Integration test uses Capybara and chromedriver, it will automatically load your chrom browser to show the test process. it will save a failed case screenshot to the tmp/capybara/ folder if there is any exception.
I use VCR to record the 3rd party yahoo API response, the test is always independment with external api service status.

Other unit test for controller and weather API in Rspec.
it shows the documentation for testing in the terminal.

```
~/project/weather-app [master] $ bundle exec rspec

HomeController
  GET index
    renders the index template
    when has user input
      should call api with params
      creates forecast, location, weather resources
      when has exception from API
        does not create resources
    when no user input
      does not call api

WeatherApi
  .search_by_woeid
    gets sydney in the response title
    gets sydney in the response city
    gets c for the temperature unit
    gets forecasts data
  .search_by_city_name
    gets melbourne in the response title
    gets melbourne in the response city
    gets f for the temperature unit
    gets forecasts data
  send valid_unit method
    valid unit
      does not raise exception
    invalid unit
      raises Weather Error msg
      raises Weather Error code 400

Weather app home page
Capybara starting Puma...
* Version 3.12.0 , codename: Llamas in Pajamas
* Min threads: 0, max threads: 4
* Listening on tcp://127.0.0.1:61567
  user accesses the page without any input
  user chooses sydney location and CELSIUS temp unit
  user chooses melbourne location and FAHRENHEIT temp unit

Finished in 12.47 seconds (files took 4.72 seconds to load)
19 examples, 0 failures
```

* Run the app
  - start rails server : rails s
  - type url <address>lvh.me:3000</address> in the browser
  - choose options from selects and click refresh button
  - you will see the weather details.

Each time the weather is checked, the result will be saved to database.

forecasts table save request location(city name), request created at time, current weather condition.
weather table save the weather forecasts for future days on this checking.
one forcast record has multiple(future days) weather records for forecast deatils.
locations table records the  each time request location detail info: city, region, country

