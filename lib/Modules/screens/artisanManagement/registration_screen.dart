import 'package:bhk_employee/Modules/screens/profileManagement/main_profile.dart';
import 'package:bhk_employee/common/common_widgets.dart';
import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/resources/validator.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../resources/colors.dart';
import '../../../resources/images.dart';
import '../../../resources/inputformatter.dart';
import '../../../resources/strings.dart';
import '../../controller/registrationcontroller.dart';
import 'VideoPlayerScreen.dart';

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
            appBar: topAppBar(appStrings.registration),
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: controller.profileRefresh,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    artisanAvatar(controller,context),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Center(
                        child: Column(
                          children: [
                            Text("${appStrings.maximumFileSize} 5 MB*", style: TextStyle(color: appColors.grayShade2)),
                            Text("${appStrings.acceptedFileTypes} jpg,png,jpeg", style: TextStyle(color: appColors.grayShade2)),
                          ],
                        ),
                      ),
                    ),
                    20.kH,
                    detailForm(controller, w, h),
                    12.kH,

                    commonComponentRedStar("Inro Video",mandatory: false),
                    Container(padding: EdgeInsets.all(8),decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(width: 1.2,color: Colors.grey)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Introductory Video",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w400),),
                          Obx(() {
                            final hasVideo = controller.introVideoFile.value != null;

                            return GestureDetector(
                              onTap: () {
                                if (hasVideo) {
                                  Get.to(() => VideoPlayerScreen(), arguments: {
                                    'videoFile': controller.introVideoFile.value!
                                  });
                                } else {

                                  bottomDrawerVideoFile(
                                    context,
                                    h * 0.25,
                                    w,
                                    controller.introVideoFile,
                                        () {
                                      pickVideoFromGallery(controller.introVideoFile, true);
                                    },
                                        () {
                                      pickVideoFromGallery(controller.introVideoFile, false);
                                    },
                                  );
                                }
                              },
                              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Container(
                                    padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: appColors.brownDarkText,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: appColors.brown, width: 1.5),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                         Icon(hasVideo ? Icons.play_circle_fill:Icons.emergency_recording, color: appColors.white, size: 20),
                                         SizedBox(width: 6),
                                        Text(
                                          hasVideo ? appStrings.preview : appStrings.addVideo,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  if (controller.introVideoFile.value != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: GestureDetector(
                                        onTap: () => controller.removeIntroVideo(),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            decoration: BoxDecoration(color: appColors.brown.shade300, shape: BoxShape.circle),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Icon(Icons.close, size: 17, color: appColors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    )

                  ],
                ),
              ),

            ),
            bottomNavigationBar: Padding(
              padding:  EdgeInsets.only(top: 16.0,bottom: 32,right: 16,left: 16),
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
                      controller.selectedExpertises.isEmpty== true ) {
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
      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(color: appColors.grey[300], borderRadius: BorderRadius.circular(10)),
              ),
              16.kH,
              Text(appStrings.OTPVerification, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              8.kH,
              Text(
                appStrings.enterTheOTPSentToYourPhone,
                style: TextStyle(fontSize: 14, color: appColors.grey),
                textAlign: TextAlign.center,
              ),
              20.kH,

              otpField(context, otpController.value, 6, (pin) => controller.otp.value = pin.toString(), backgroundColor:  appColors.cardBackground),



              Obx(() => controller.startTime.value > 0
                  ? Text(
                "${appStrings.resendIn} ${controller.startTime.value} ${appStrings.sec}",
                style: TextStyle(fontSize: 14, color: appColors.black),
              )
                  : InkWell(
                onTap: () {
                  controller.resendOtp(context);
                  controller.startTimer();
                },
                child: Text(
                  appStrings.resendOTP,
                  style: TextStyle(fontSize: 14, color: appColors.blue),
                ),
              )),


              18.kH,

              commonButton(double.infinity, 45, appColors.brownDarkText, appColors.white, () => controller.otpVerification(), hint: appStrings.verifyPhoneNumber, radius: 30),

              20.kH,
            ],
          ),
        );
      },
    );
  }
}

Widget artisanAvatar (RegistrationController controller,context){
  return  Center(
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
                child: ClipRRect(borderRadius: BorderRadius.circular(70),
                    child: Image.asset(AppImages.profile,height: 140,width: 140,fit: BoxFit.cover,)),
              )
                  : Container(
                  alignment: const Alignment(0.0, 2.5),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image.file(controller.imageFiles.value!,height: 140,width: 140,fit: BoxFit.cover,),

                  )
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.0, left: 90.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.green,
                    height: 40,
                    width: 40,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () {
                        controller.openImages(context);
                      },
                    ),
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget detailForm (RegistrationController controller,double w,double h){
  return Column(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.edit_document, size: 20.0, color: appColors.blue),
          8.kW,
          Text(appStrings.personalInformation, style:  TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
        ],
      ),
      20.kH,
      commonComponent(appStrings.firstName, commonTextField(controller.fNameController.value, controller.fNameFocusNode.value, w, (value) {}, hint: appStrings.enterYourFirstName, fontSize: 14)),
      12.kH,
      commonComponent(appStrings.lastName, commonTextField(controller.lNameController.value, controller.lNameFocusNode.value, w, (value) {}, hint: appStrings.enterYourLastName, fontSize: 14)),
      12.kH,
      commonComponent(appStrings.aadhaarNumber, commonTextField(controller.aadhaarController.value, controller.aadhaarFocusNode.value, maxLength: 16, keyboardType: TextInputType.number, w, (value) {}, hint: appStrings.enterYourAadhaarNumber, fontSize: 14,isCounter: true)),
      commonComponent(mandatory: false,appStrings.gSTNumber, commonTextField(controller.GSTController.value, controller.GSTFocusNode.value, maxLength: 15, keyboardType: TextInputType.number, w, (value) {}, hint: appStrings.enterYourGSTrNumber, fontSize: 14,isCounter: true)),

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

      multiSelectExpertiseInline(controller, w,h),

    ],
  );
}


Widget multiSelectExpertiseInline(
    RegistrationController controller, double width, double height) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Expertise", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      5.kH,
      Obx(() {
        String selectedText = controller.selectedExpertises.isEmpty
            ? "Select Expertise"
            : controller.selectedExpertises.join(" ,  ");

        return commonDropdownButtonWidgetHint(

          controller.Expertise.map((exp) {
            return DropdownMenuItem<String>(
              value: exp,
              enabled: false,
              child: Obx(() => CheckboxListTile(
                value: controller.selectedExpertises.contains(exp),
                title: Text(exp, style: const TextStyle(fontSize: 14)),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                onChanged: (val) {
                  if (val == true) {
                    controller.selectedExpertises.add(exp);
                  } else {
                    controller.selectedExpertises.remove(exp);
                  }
                },
              )),
            );
          }).toList(),
          null,
          width,
          height,
          Colors.white,
            Chip(
                          label: Text(selectedText, style: TextStyle(fontSize: 12)),
                          backgroundColor: appColors.backgroundColorSecond,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
              (val) {},
          hint: selectedText,
          borderColor: appColors.border,
        );
      }),
    ],
  );
}

Widget commonDropdownButtonWidgetHint(List<DropdownMenuItem<String>>? items,String? selectedValue, double width, double height, Color color,Widget hintWidget ,void Function(String?) onChanged, {String hint = '', Color borderColor = Colors.transparent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
      border: Border.all(color: borderColor, width: 1.5),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: DropdownButton2<String>(
      hint: hintWidget,
      style: TextStyle(fontSize: 14, color: Colors.black),
      value: selectedValue,
      items: items,
      onChanged: onChanged,
      dropdownStyleData: DropdownStyleData(
        maxHeight: height * .25,
        width: width * .918,
        offset: const Offset(-9, -3),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      ),
      isExpanded: true,
      underline: const SizedBox(),
    ),
  );
}
