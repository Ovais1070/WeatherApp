**Overview**
------------

WeatherApp uses Openweathermap API and build with Swift & SwiftUI.

**Key Features:**
-----------------

1: Support iOS 15 and up

2: Users can enter the name of a city to get the current weather information.

3: Displays weather information, including like temperature, weather description, and an icon representing the weather condition.

4: Error handling for cases such as no internet connection or invalid city names.

5: Refresh mechanism to update the weather data.

6: Location suggestions as user types in City

Installation
------------

Clone or download the project to your local machine

Open the project in Xcode

Replace {Your Appid} with your valid Openweathermap API key in NetworkServices.swift

struct AppData {

    static var appid: String = "{Your Appid}"

}

Run the project on device
