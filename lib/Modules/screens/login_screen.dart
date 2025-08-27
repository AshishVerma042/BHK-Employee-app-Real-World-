import 'dart:math';

import 'package:bhk_employee/common/common_widgets.dart';
import 'package:bhk_employee/common/myUtils.dart';
import 'package:bhk_employee/resources/images.dart';
import 'package:bhk_employee/resources/inputformatter.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/response/status.dart';

import 'package:get/get.dart';
import '../../Constants/constants.dart';
import '../../main.dart';
import '../controller/logincontroller.dart';

class LoginScreen extends ParentWidget {
  const LoginScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    LoginController controller = Get.put(LoginController());
    return Obx(() => Stack(
          children: [
            Container(
                width: w,
                height: h,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Constant.backgroundImage), fit: BoxFit.cover)),
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    topRoundedHeader(w,h, controller),
                    50.kH,
                    if (controller.errorMessage.value != "") errorToggle(controller),
                    SizedBox(height: h * 0.1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        appStrings.letsSignIn,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    5.kH,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        appStrings.welcomeBack,
                        style: const TextStyle(fontSize: 15, color: Colors.white, decoration: TextDecoration.none),
                      ),
                    ),

                    60.kH,
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: phoneTextField(controller.phoneController.value, controller.phoneNumberFocusNode.value, w, 40,
                              onCountryChanged: (country) {
                             controller.countryCode.value = country.dialCode;
                             controller.phoneController.value.text = "";
                             print('${controller.phoneController.value.text} ${country.dialCode}');
                          },
                              onCountryCodeChange: (phone) {
                            controller.errorMessage.value = "";
                            controller.countryCode.value = phone.countryCode;
                            if (phone.number.isNotEmpty) {
                              controller.emailController.value.text = "";
                            }
                          },
                              hint: appStrings.phone, inputFormatters: [NoLeadingZeroFormatter(), FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)])),
                    ),
                    20.kH,
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: commonButton(w, 45, Color.fromARGB(255, 204, 157, 118), Colors.white, () {
                          if (controller.emailController.value.text.isEmpty && controller.phoneController.value.text.isEmpty) {
                            controller.errorMessage.value = appStrings.loginerrormessage;
                          } else {
                            controller.errorMessage.value = "";
                            FocusScope.of(context).unfocus();
                            controller.logInAndRegister(context);
                          }
                        }, radius: 30, hint: appStrings.getOTP)),
                    SizedBox(height: h * 0.20),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(appStrings.privacyPolicy, style: const TextStyle(fontSize: 12, color: Colors.white))),
                  ],
                ))),
             progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w)
          ],
        ));
  }
}

Widget topRoundedHeader(double w,double h, LoginController controller){
  return Container(
    height: h * 0.17,
    width: w,
    decoration: const BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(150), bottomLeft: Radius.circular(150))),
    child: Column( mainAxisAlignment: MainAxisAlignment.end,
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
                  height: h * 0.13,
                  fit: BoxFit.contain,
                ),
              ),
              Image.asset(
                AppImages.logo,
                width: 45,
                height: 45,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget errorToggle(LoginController controller) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.red[100],
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error, color: Colors.red),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
