import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bhk_employee/Modules/controller/artisancontroller.dart';
import 'package:bhk_employee/Modules/model/expertiseModel.dart';
import 'package:bhk_employee/common/map_geolocation/mapcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/utils.dart';
import '../../common/CommonMethods.dart';
import '../../common/Constants.dart';
import '../../common/common_widgets.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';

import 'package:bhk_employee/Modules/model/artisanRegistrationModel.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../model/verifyOtpModel.dart';
import '../repository/registrationRepository.dart';

class RegistrationController extends GetxController {
  ArtisanController artisanController = Get.put(ArtisanController());

  var introVideoFile = Rxn<File>();

  var isExpertiseDropdownOpen = false.obs;


  var imagefiles = <String>[].obs;
  bool isWhite = false;
  var fNameController = TextEditingController().obs;
  var lNameController = TextEditingController().obs;
  var aadhaarController = TextEditingController().obs;
  var GSTController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var addressController = TextEditingController().obs;
  var expertiseController = TextEditingController().obs;
  var subCastController = TextEditingController().obs;
  var otp = "".obs;
  final verifyOTPData = VerifyOTPModel().obs;


  var Expertise = <String>[].obs;
  var casteCategories =<String> ["General", "OBC", "SC" , "ST"].obs;



  void setVerifyData(VerifyOTPModel value) => verifyOTPData.value = value;
  var selectedExpertise = "".obs;


  RxList<String> selectedExpertises = <String>[].obs; // multiple selected
  var selectedCast = Rxn<String>();
  var expertiseFocusNode = FocusNode().obs;
  var subCastFocusNode = FocusNode().obs;
  var aadhaarFocusNode = FocusNode().obs;
  var GSTFocusNode = FocusNode().obs;
  var emailFocusNode = FocusNode().obs;
  var fNameFocusNode = FocusNode().obs;
  var lNameFocusNode = FocusNode().obs;
  var phoneFocusNode = FocusNode().obs;
  var addressFocusNode = FocusNode().obs;

  LocationController locationController = Get.put(LocationController());

  final _api = RegistrationRepository();

  var countryCode = "".obs;
  var checkInternetValue = false.obs();
  var errorMessage = "".obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final artisanRegistrationData = ArtisanRegistrationModel().obs;
  void setRegistrationData(ArtisanRegistrationModel value) => artisanRegistrationData.value = value;

  var textFieldFocusNode = FocusNode().obs;

  var items = ['Handicraft', 'Handloom'];
  var selectedItem = "Handloom".obs;
  void updateItem(String? value) {
    selectedItem.value = value!;
  }

  Future<void> artisansRegister(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        if (emailController.value.text.isNotEmpty) "email": emailController.value.text,
        "firstName": fNameController.value.text,
        "lastName": lNameController.value.text,
        "phoneNo": phoneController.value.text,
        "countryCode": countryCode.value,
        "expertizeField": selectedExpertises.join(),
        "longitude":locationController.longitude.value,
        "latitude":locationController.latitude.value
        // "aadharNumber": addressController.value.text,
      };
      Utils.printLog(data);
      _api
          .artisanRegistrationApi(data)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setRegistrationData(value);
            CommonMethods.showToast("${value.message}");
            Utils.printLog("Response===> ${value.toString()}");
            print("redirect");
          })
          .onError((error, stackTrace) {
            setError(error.toString());
            setRxRequestStatus(Status.ERROR);
            if (error.toString().contains("{")) {
              var errorResponse = json.decode(error.toString());
              print("errrrorrr=====>$errorResponse");
              if (errorResponse is Map || errorResponse.containsKey('message')) {
                CommonMethods.showToast(errorResponse['message']);
              } else {
                CommonMethods.showToast("An unexpected error occurred.");
              }
            }
            Utils.printLog("Error===> ${error.toString()}");
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
  var startTime = 30.obs;
  Timer? _timer;

  void startTimer() {
    startTime.value = 30; // reset to 30 seconds
    _timer?.cancel();     // cancel any old timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (startTime.value > 0) {
        startTime.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }


  final expertiseListData = ExpertiseModel().obs;
  void setgetexpertisModeldata(ExpertiseModel value) => expertiseListData.value = value;

  Future<void> getExpertiseApi() async {
    setRxRequestStatus(Status.LOADING);
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {

      _api.getexpertiseApi()
          .then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setgetexpertisModeldata(value);
        Utils.printLog("Response===> ${value.toString()}");
        Expertise.clear();

        if (value.data?.docs != null && value.data!.docs!.isNotEmpty) {
          Expertise.addAll(
            value.data!.docs!.map((doc) => doc.categoryName ?? "").toList(),
          );
          selectedExpertise.value = Expertise.first;
        }
      })
          .onError((error, stackTrace) {
        handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }


  Future<void> otpVerification() async {
    var connection = await CommonMethods.checkInternetConnectivity();

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      Map<String, dynamic> data = {"referenceId": artisanRegistrationData.value.data?.referenceId, "otp": otp.value.toString()};
      _api
          .verifyOtpApi(data)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setVerifyData(value);
            CommonMethods.showToast("OTP Verified Successfully ");
            redirect();
          })
          .onError((error, stackTrace) {
            setError(error.toString());
            setRxRequestStatus(Status.ERROR);
            CommonMethods.showToast("OTP verification failed ");
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  void redirect() {
    print("redirect");
    Utils.savePreferenceValues(Constants.referenceId, "${artisanRegistrationData.value.data?.referenceId}");
    Get.back();
    Future.delayed(Duration(milliseconds: 200), () {
      Get.back();
    });
    artisanController.getArtisanListApi();

  }

  var imageFiles = Rxn<File>();
  var videofiles = Rxn<File>();
  String errormessage = "";

  bool status = true;
  bool isprofileimage = false;

  Future<void> profileRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    selectedExpertises.value = [];
    fNameController.value.clear();
    lNameController.value.clear();
    emailController.value.clear();
    aadhaarController.value.clear();
    phoneController.value.clear();
    addressController.value.clear();
    updateItem(selectedItem.value);
  }


  void resendOtp(BuildContext context) {

    artisansRegister(context);
    Get.snackbar("OTP", "New OTP has been sent to your phone");
  }


  void verifyOtp(BuildContext context) {
    if (otp.value.length == 6) {
      // call API to verify OTP
      Get.back(); // close bottom sheet
      Get.snackbar("Success", "OTP Verified Successfully");
    } else {
      Get.snackbar("Error", "Please enter a valid 6-digit OTP");
    }
  }

  openImages(context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      imageFiles.value = imageTemp;
      isprofileimage = true;
      print("profile $isprofileimage");
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void removeIntroVideo() {
    introVideoFile.value = null;
  }


  @override
  void onInit() {
    super.onInit();
    getExpertiseApi();
  }
}
