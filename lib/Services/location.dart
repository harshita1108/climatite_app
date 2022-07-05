import 'package:geolocator/geolocator.dart';

class Location{
  double latitude;
  double longitude;

  Future<void> GetCurrentLocation() async{
    try {
      Position position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy
              .high); // more accuracy more battery consumption so select accuracy level wisely

      latitude = position.latitude;
      longitude = position.longitude;

    }// GO TO ANDROID->APP->SRC->MAIN->ANDROIDMANIFESTO.XML // FOR DIALOG BOX LIKE THIS APPS NEEDS ACCESS TO LOCATION SOME LINES OF CODE ADDED HERE
    // try and catch prevent app from crashing in case error occurs. (Null Aware operator used as : variable ?? default value i.e. in case variable has right value it will be executed else the default value will be executed)
    catch (e){
      print(e);
    }
  }
// IOS->RUNNER->INFO.PLIST DO ADD LINES OF CODE HERE FOR THE SAME DIALOG BOX IN IOS
// AndroidXCompatibility-> in case app crashes visit this and use as specified in flutter documentation
  }