import 'dart:math';

import 'package:bhk_employee/Modules/controller/splashController.dart';
import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/resources/images.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends ParentWidget {
  const SplashScreen({super.key});
  @override
  Widget buildingView(BuildContext context, double h, double w) {
    SplashController controller = Get.put(SplashController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(195, 247, 243, 233),
      body: Stack(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: controller.animationController.value * 2 * pi,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    AppImages.loaderouter,
                  ),
                ),
                Image.asset(
                  AppImages.logo,
                  width: 70,
                  height: 70,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Text(
              appStrings.appNameSplash,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:
                    Color.fromARGB(255, 123, 64, 35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
