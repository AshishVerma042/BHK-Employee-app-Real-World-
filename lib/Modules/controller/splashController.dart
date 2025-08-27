import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/utils.dart';
import '../../common/Constants.dart';
import '../../routes/RoutesClass.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    navigate();
  }
  void navigate(){
  Utils.getPreferenceValues(Constants.accessToken).then((value)=>{
    if (value != "" && value != null)
      {
        Future.delayed(const Duration(seconds: 7), () {
          Get.offAllNamed(RoutesClass.commonScreen);
        }),
        print(value)
      }
    else{
      Future.delayed(const Duration(seconds: 7), () {
        Get.offAllNamed(RoutesClass.login);
      }),
      print(value)
    }
  });
}

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
