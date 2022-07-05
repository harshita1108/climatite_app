import 'package:climate_app/services/location.dart';
import 'package:climate_app/services/networking.dart';

const apiKey = '2aedd3da7959425aa838724afc43243f';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel { // created a class
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper( // it is as NetworkHelper(url)
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');



    var weatherData = await networkHelper.getData();
    return weatherData; // output of getCityWeather method
  }

  Future<dynamic> getLocationWeather() async { //dynamic is the datatype of future
    Location location = Location();
    await location.GetCurrentLocation();
    // dynamic as it works asynchonously
    NetworkHelper networkHelper = NetworkHelper(  // and then with help of network helper we get the weather data for that location
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');  // metric to get temperature in celsius
    // used {} in location.latitude and further because if we use just $location.latitude we would only go to first step which is location hence added {} to reach latitude also
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) { // first method of WeatherModel class taking condition as input
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍'; // these icons are seen from a table in weathericons and comparing the values we made this if else statement
    }
  }

  String getMessage(int temp) {  // second method of WeatherModel class taking temp as input
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}


// openweathermap -> weathericons