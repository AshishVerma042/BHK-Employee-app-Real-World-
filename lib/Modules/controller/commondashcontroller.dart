import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/dashboardManagement/home_screen.dart';
import '../screens/artisanManagement/artisans.dart';
import '../screens/productManagement/product_screen.dart';
import '../screens/profileManagement/main_profile.dart';

class CommonDashController extends GetxController {
  var selectedIndex = 0.obs;

  int changeIndex() {
    if (selectedIndex.value <= 4) {
      return selectedIndex.value;
    } else {
      return 0;
    }
  }

  final List<Widget> pages = [
    const HomeScreen(), //index=0
    const Artisans(), //index=1
    // const ProductScreen(), //index=2
    const MainProfile(), //index=3
  ];

  List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.diversity_3_outlined), label: 'Artisans'),
    // BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Product'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];
}
