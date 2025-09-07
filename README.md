# Weather App

WeatherApp is mobile application built with Flutter that allows users to check the weather for selected cities and their current location. The app also shows a 5-day forecast with minimum, maxiumum temperatures and weather conditions.

## Features

1. Weather for selceted cities - the app shows current weather in Gliwice and Hamburg by default.
2. Add new city - users can add any city and immediately see its weather.
3. Weather at your current location - the app uses GPS to detect user's location and show the weather in this location.
4. 5-day forecast - for each city, the app displays minimum and maximum temperature and weather condtions for the next 5 days.

## How to Run the App

### Requirements:

- Flutter SDK (version >= 3.9.0).
- Android Studio or Xcode.

### Install dependencies:
- flutter pub get, 
- open ios/Runner.xcworkspace (for iOs),
- flutter run (for Android),
- set latitude and londitude in simulator (Features -> Location -> Custom Location).
## Potential Issues and Solutions

1. Module 'geocoding_ios' not found:
   - flutter clean,
   - rm -rf ios/Pods ios/Podfile.lock,
   - flutter pub get,
   - cd ios,
   - pod repo update,
   - pod install,
   - cd ..,
   - flutter run.
2. Not location found:
   - check info.plist file - there should be 'Privacy - Location When In Use Usage Description' added. 
3. Wrong location on Simulator:
   - When simulator runs - Features -> Location -> Custom Location.
   - Set the desired latitude and longitude for testing. 

   
