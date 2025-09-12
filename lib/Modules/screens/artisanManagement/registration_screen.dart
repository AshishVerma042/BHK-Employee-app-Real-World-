import 'package:bhk_employee/common/common_widgets.dart';
import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/resources/validator.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../resources/appconstants.dart';
import '../../../resources/colors.dart';
import '../../../resources/images.dart';
import '../../../resources/inputformatter.dart';
import '../../../resources/strings.dart';
import '../../controller/registrationcontroller.dart';

class Registration extends ParentWidget {
  const Registration({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(RegistrationController());
    var otpController = TextEditingController().obs;



    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            appBar: AppBar(
              flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppConstants.customGradient)),
              iconTheme: const IconThemeData(color: Colors.white),
              title:  Text(appStrings.registration, style: TextStyle(color: Colors.white, fontSize: 24)),
              centerTitle: true,
            ),
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: controller.profileRefresh,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Stack(
                          fit: StackFit.loose,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.imageFiles.value == null
                                    ? Container(
                                        alignment: const Alignment(0.0, 2.5),
                                        child: CircleAvatar(backgroundColor: Color.fromARGB(195, 250, 248, 242), backgroundImage: AssetImage(AppImages.profile), radius: 70.0),
                                      )
                                    : Container(
                                        alignment: const Alignment(0.0, 2.5),
                                        child: CircleAvatar(backgroundImage: FileImage(controller.imageFiles.value!), radius: 70.0),
                                      ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 100.0, left: 90.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 20.0,
                                    child: IconButton(
                                      icon:   Icon(Icons.camera_alt),
                                      color: Colors.white,
                                      onPressed: () {
                                        controller.openImages(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Center(
                        child: Column(
                          children: [
                            Text("${appStrings.maximumFileSize} 5 MB*", style: TextStyle(color: const Color.fromARGB(221, 100, 97, 97))),
                            Text("${appStrings.acceptedFileTypes} jpg,png,jpeg", style: TextStyle(color: const Color.fromARGB(221, 100, 97, 97))),
                          ],
                        ),
                      ),
                    ),
                    20.kH,
                    Row(
                      children: [
                        const Icon(Icons.edit_document, size: 20.0, color: Colors.blue),
                        8.kW,
                        Text(appStrings.personalInformation, style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    20.kH,

                    commonComponent(appStrings.firstName, commonTextField(controller.fNameController.value, controller.fNameFocusNode.value, w, (value) {}, hint: appStrings.enterYourFirstName, fontSize: 14)),
                    12.kH,
                    commonComponent(appStrings.lastName, commonTextField(controller.lNameController.value, controller.lNameFocusNode.value, w, (value) {}, hint: appStrings.enterYourLastName, fontSize: 14)),
                    12.kH,
                    commonComponent(appStrings.aadhaarNumber, commonTextField(controller.aadhaarController.value, controller.aadhaarFocusNode.value, maxLength: 16, keyboardType: TextInputType.number, w, (value) {}, hint: appStrings.enterYourAadhaarNumber, fontSize: 14,isCounter: true)),

                    commonComponentRedStar(appStrings.phoneNumber),
                    innerPhoneTextField(
                      controller.phoneController.value,
                      controller.phoneFocusNode.value,
                      w,
                      40,
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
                      hint: appStrings.phone,
                      inputFormatters: [NoLeadingZeroFormatter(), FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: commonComponent(
                            appStrings.category,
                            commonDropdownButton(
                              controller.casteCategories.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              controller.selectedCast.value,
                              w,h,
                              appColors.backgroundColor,
                                  (value) {
                                  controller.selectedCast.value = value;
                              },
                              hint: appStrings.selectCategory,
                              borderColor: appColors.border,
                            ),
                          ),
                        ),
                        10.kW,
                        Expanded(
                          child: commonComponent(
                            "Caste",
                            commonTextField(controller.subCastController.value, controller.subCastFocusNode.value, w, (value) {}, hint: "Enter your Community", fontSize: 14),

                          ),
                        ),
                      ],
                    ),
                    12.kH,


                    Text(appStrings.email, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    5.kH,
                    commonTextField(controller.emailController.value, controller.emailFocusNode.value, w, (value) {}, keyboardType: TextInputType.emailAddress, hint: appStrings.enterYourEmail, fontSize: 14),
                    12.kH,
                    commonComponent(appStrings.address, commonTextField(controller.addressController.value, controller.addressFocusNode.value, w, maxLines: 4, (value) {}, hint: appStrings.enterYourCurrentAddress, fontSize: 14)),
                    12.kH,
                    // commonComponentRedStar("Expertise"),
                    // 5.kH,
                    // dropDownList(controller),
                    commonComponent(
                      appStrings.expertise,
                      commonDropdownButton(
                        controller.subExpertise.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        controller.selectedExpertise.value,
                        w,h,
                        appColors.backgroundColor,
                            (Value) {
                          controller.selectedExpertise.value = Value;
                        },
                        hint: appStrings.selectExpertise,
                        borderColor: appColors.border,
                      ),
                    ),
                    Text(controller.errormessage, style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),

            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(top: 16.0,bottom: 32,right: 16,left: 16),
              child: commonButton(
                double.infinity,
                50,
                appColors.contentButtonBrown,
                Colors.white,
                    () {
                  if (controller.fNameController.value.text.isEmpty ||
                      controller.lNameController.value.text.isEmpty ||
                      controller.phoneController.value.text.isEmpty ||
                      controller.addressController.value.text.isEmpty ||
                      !Validator.isEmailValid(controller.emailController.value.text) ||
                      controller.selectedExpertise.value?.isEmpty== true ) {
                    controller.errorMessage.value = appStrings.artisanRegistererrormessage;
                  } else {
                    controller.errorMessage.value = "";
                    controller.artisansRegister(context);
                    showOtpBottomSheet(context, controller,  otpController);

                  }
                },
                radius: 30,
                hint: appStrings.submit,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showOtpBottomSheet(BuildContext context, RegistrationController controller, Rx<TextEditingController> otpController) {
    controller.startTimer();
    showModalBottomSheet(backgroundColor: appColors.cardBackground,
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
              ),
              16.kH,
              Text(appStrings.OTPVerification, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              8.kH,
              Text(
                appStrings.enterTheOTPSentToYourPhone,
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              20.kH,

              otpField(context, otpController.value, 6, (pin) => controller.otp.value = pin.toString(), backgroundColor:  appColors.cardBackground),



              Obx(() => controller.startTime.value > 0
                  ? Text(
                "${appStrings.resendIn} ${controller.startTime.value} ${appStrings.sec}",
                style: TextStyle(fontSize: 14, color: Colors.black),
              )
                  : InkWell(
                onTap: () {
                  controller.resendOtp(context);
                  controller.startTimer();
                },
                child: Text(
                  appStrings.resendOTP,
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              )),

              //  InkWell(
              //   onTap: () {
              //     controller.resendOtp(context);
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.only(top: 6),
              //     child: Text(
              //       "Resend OTP",
              //       style: TextStyle(fontSize: 14, color: Colors.blue),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
              // controller.startTime.value > 0
              //     ? Padding(
              //   padding: EdgeInsets.only(top: 6),
              //   child: Text(
              //     '${appStrings.reSendCode}${controller.startTime.value} ${appStrings.sec}',
              //     style: TextStyle(
              //       fontSize: 14,
              //       color: Colors.white,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // )
              //     : InkWell(
              //   onTap: () {
              //     controller.resendOtp(context);
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.only(top: 6),
              //     child: Text(
              //       "Resend OTP",
              //       style: TextStyle(fontSize: 14, color: Colors.blue),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),


              18.kH,

              commonButton(double.infinity, 45, appColors.brownDarkText, Colors.white, () => controller.otpVerification(), hint: appStrings.verifyPhoneNumber, radius: 30),

              20.kH,
            ],
          ),
        );
      },
    );
  }
}

