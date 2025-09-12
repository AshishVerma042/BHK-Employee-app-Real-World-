import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;   // 👈 prefix
class LocationController extends GetxController {
  var location = "Fetching location...".obs;
  var longitude = 0.0.obs;
  var latitude = 0.0.obs;
  var place = <geo.Placemark>[].obs; // 👈 store full list of placemarks

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

      // Convert coordinates to address
      List<geo.Placemark> placemarks =
      await geo.placemarkFromCoordinates(pos.latitude, pos.longitude);

      if (placemarks.isNotEmpty) {
        place.assignAll(placemarks); // 👈 save whole list
        final firstPlace = place.first;

        location.value =
        "${firstPlace.street}, ${firstPlace.subLocality}, ${firstPlace.locality}, ${firstPlace.administrativeArea}, ${firstPlace.country}";
      } else {
        location.value = "No address available";
      }
    } catch (e) {
      location.value = "Error: $e";
    }
  }
}
