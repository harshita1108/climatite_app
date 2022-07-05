import 'package:flutter/material.dart';
import 'package:climate_app/Screens/location_screen.dart';
import 'package:climate_app/Services/Weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; //this package gets us access to various loading indicators

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //( VISIT ... IN EMULATOR AND SET CURRENT LOCATION FOR THE PHONE)

  @override
  void initState() {
    super.initState();
  } // gets triggered as soon as stateful widget gets created

  void getLocationData() async {
    // using getlocation data getting location from user
    // getting gps location etc are time consuming tasks hence to avoid freezing of ui and to run these time consuming task at background we use async

    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      // used this to navigate to location_screen
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white70,
          size: 100.0,
        ),
      ),
    );
  }
}
// life cycle methods: in stateful widget
// initState , deactivate , build -- most frequently used methods
