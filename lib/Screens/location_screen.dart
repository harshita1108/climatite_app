import 'package:flutter/material.dart';
import 'package:climate_app/Utilities/constants.dart';
import 'package:climate_app/Services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel();
  int temperature; //as we want temperature without decimal value
  String WeatherIcon; // emojis processed same way as string
  String cityName;
  String WeatherMessage;

 @override
  void initState() {

    super.initState();
    updateUI(widget.locationWeather); // when we give location weather we tap into updated ui using this to get temp condition and name
    
  }

  void updateUI(dynamic weatherData){ // A METHOD
   setState(() {

     if(weatherData == null){ // app may crash in case we don't do this for various reasons like location disabled in phone settings
       temperature = 0;
       WeatherIcon = 'Error';
       WeatherMessage = 'Unable to get Weather Data';
       cityName = ''; // A empty string
       return; // to exit this function
     } // can give a pop up also
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt(); //
    var condition = weatherData['weather'][0]['id']; // the data passed from here to below
    WeatherIcon = weather.getWeatherIcon(condition); // here we pass condition so depending on value of condition that is 200 300 etc it will go to weather.dart and match values in if else and return the respective emoji
    WeatherMessage = weather.getMessage(temperature);
    cityName = weatherData['name'];
   });
  } //wrapped in set state as it will reflect changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async { // await and async as it will ba future bases that is we dont knolsw when user types cityname
                      var typedName = await Navigator.push( // once cityscreen gets pushed on top of locationscreen user types cityname going to cityname and then pops the cityname after typing and comes back here returning cityname
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                        await weather.getCityWeather(typedName); // return future
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°', // getting temperature
                      style: kTempTextStyle,
                    ),
                    Text(
                      WeatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$WeatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

