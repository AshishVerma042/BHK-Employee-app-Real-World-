import 'package:bhk_employee/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'mapcontroller.dart';

class MapScreen extends ParentWidget {
  const MapScreen({super.key});
  @override
  Widget buildingView(BuildContext context, double h, double w) {
     LocationController locationController = Get.put(LocationController());

    return Scaffold(
      appBar: AppBar(title: Text("Geolocation Example")),
      body: Center(
        child: Obx(() => Text(locationController.location.value)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => locationController.getCurrentLocation(),
        child: Icon(Icons.location_on),
      ),
    );
  }
}
