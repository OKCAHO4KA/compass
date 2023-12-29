import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final watchLocationProvider =
    StreamProvider.autoDispose<(double lat, double lng)>((ref) async* {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    // return Future.error('Location services are disabled.'); мы напишем так:

    throw 'Location services are disabled.';
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      //
      // return Future.error('Location permissions are denied');
      throw 'Location permissions are denied';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    //
    // return Future.error('Location permissions are permanently denied, we cannot request permissions.');

    throw 'Location permissions are permanently denied, we cannot request permissions.';
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  //
  // return await Geolocator.getCurrentPosition();
  // final location = await Geolocator.getCurrentPosition();

  await for (final pos in Geolocator.getPositionStream()) {
    yield (pos.latitude, pos.longitude);
  }
});