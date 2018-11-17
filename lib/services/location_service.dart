import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class LocationService {

  static final brazilLocation = LatLng(-22.34, -48.05);

  static Future<Position> getGPSPosition() async {
    return await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  static void checkGPSSatus() async {
    GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
    switch (geolocationStatus) {
      case GeolocationStatus.granted:
        print('GPS status granted');
        break;
      case GeolocationStatus.denied:
        print('GPS status denied');
        break;
      case GeolocationStatus.disabled:
        print('GPS status disable');
        break;
      case GeolocationStatus.restricted:
        print('GPS status restricted');
        break;
      case GeolocationStatus.unknown:
        print('GPS status unknown');
        break;
    }
  }
}