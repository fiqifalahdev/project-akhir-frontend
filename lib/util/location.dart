import 'package:geolocator/geolocator.dart';

class LocationServices {
  late String longitude = '';
  late String latitude = '';

  // Get user location
  Future<Position> getLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    longitude = await Geolocator.getCurrentPosition()
        .then((value) => value.longitude.toString());
    latitude = await Geolocator.getCurrentPosition()
        .then((value) => value.latitude.toString());

    print("long: $longitude");
    print("lat: $latitude");

    return await Geolocator.getCurrentPosition();
  }
}
