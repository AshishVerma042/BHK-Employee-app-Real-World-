import 'dart:math';

import 'package:bhk_employee/common/common_widgets.dart';
import 'package:bhk_employee/common/myUtils.dart';
import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/resources/colors.dart';
import 'package:bhk_employee/resources/images.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/routes/RoutesClass.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/constants.dart';
import '../../data/response/status.dart';
import '../controller/otpController.dart';

class OtpScreen extends ParentWidget {
  const OtpScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    OtpController controller = Get.put(OtpController());
    return Obx(() => Stack(
          children: [
            Container(
                alignment: Alignment.center,
                width: w,
                height: h,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Constant.backgroundImage), fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: appColors.whiteShade,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(color: appColors.blackShade, blurRadius: 10, offset: Offset(0, 4)),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedBuilder(
                                    animation: controller.animationController,
                                    builder: (context, child) {
                                      return Transform.rotate(angle: controller.animationController.value * 2 * pi, child: child);
                                    },
                                    child: Image.asset(
                                      AppImages.loaderouter,
                                      height: h * 0.15,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Image.asset(AppImages.logo, width: 50, height: 50),
                                ],
                              ),
                            ),
                            25.kH,
                            Text(
                              appStrings.phoneVerification,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            10.kH,
                            Text(
                              appStrings.weNeedToRegisterYourPhoneWithoutGettingStarted,
                              style:  TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            30.kH,
                            otpField(context, controller.otpController.value, 6, (pin) => controller.otp.value = pin.toString()),
                            controller.startTime.value > 0
                                ? Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      '${appStrings.reSendCode}${controller.startTime.value} ${appStrings.sec}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () => controller.resendOtp(context),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Text(appStrings.reSend, style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
                                    )),
                            30.kH,
                            commonButton(w, 45, Color.fromARGB(255, 204, 157, 118), Colors.white, ()=>controller.otpVerification(context), hint: appStrings.verifyPhoneNumber, radius: 30),
                            Align(alignment: Alignment.topLeft, child: TextButton(onPressed: () => Get.offNamed(RoutesClass.gotoLoginScreen()), child: Text(appStrings.editNumber, style: TextStyle(color: Colors.white))
                            )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w)
          ],
        ));
  }
}
