import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;   // 👈 prefix

class LocationController extends GetxController {
  var location = "Fetching location...".obs;
  var longitude = 0.0.obs;
  var latitude = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        location.value = "Location services are disabled.";
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          location.value = "Location permissions are denied.";
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        location.value =
        "Location permissions are permanently denied. Please enable in settings.";
        return;
      }

      // Get coordinates
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      longitude.value = pos.longitude;
      latitude.value = pos.latitude;

      print("location==>${location.value}");

      print("longitude==>${longitude.value} latitude==>${latitude.value}");

      // // Convert coordinates to address (from geocoding package)
      // List<geo.Placemark> placemarks =
      // await geo.placemarkFromCoordinates(pos.latitude, pos.longitude);
      //
      // if (placemarks.isNotEmpty) {
      //   final place = placemarks.first;
      //   location.value =
      //   "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      //   debugPrint("location===>$place");
      //
      // } else {
      //   location.value = "No address available";
      // }
    } catch (e) {
      location.value = "Error: $e";
    }
  }
}
