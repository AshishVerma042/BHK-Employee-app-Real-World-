import 'dart:convert';

import 'package:bhk_employee/common/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Constants/utils.dart';
import '../../data/response/status.dart';
import '../../common/CommonMethods.dart';
import '../../resources/strings.dart';
import '../../routes/RoutesClass.dart';
import '../model/signUpModel.dart';
import '../repository/loginRepository.dart';

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;
  var phoneController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var countryCode = "".obs;
  final _api = LoginRepository();
  var checkInternetValue = false.obs();
  var phoneNumberFocusNode = FocusNode().obs;
  var errorMessage = "".obs;

  late final AnimationController animationController;
  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  final rxRequestStatus = Status.COMPLETED.obs;
   final logInData = SignUpModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
   void setLoginData(SignUpModel value) => logInData.value = value;

  var textFieldFocusNode = FocusNode().obs;

  // Future<dynamic> signInWithGoogle() async {
  //   try {
  //     await GoogleSignIn().signOut();
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //     print(googleUser);
  //
  //     final GoogleSignInAuthentication? googleAuth =
  //     await googleUser?.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     print("Id Token===>${credential.idToken}");
  //
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } on Exception catch (e) {
  //     // TODO
  //     print('exception->$e');
  //   }
  // }

  // Future<bool> signOutFromGoogle() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     return true;
  //   } on Exception catch (_) {
  //     return false;
  //   }
  // }

  Future<void> logInAndRegister(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "identity": emailController.value.text.isNotEmpty ? emailController.value.text : phoneController.value.text,
        "user_group": "EMPLOYEE",
        if (phoneController.value.text.isNotEmpty) "countryCode": countryCode.value // Assume you have the country code stored
      };
      Utils.printLog(data);
      _api.logInApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
         setLoginData(value);
         CommonMethods.showToast("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        redirect();
      }).onError((error, stackTrace) {
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

  void redirect() {
    print("redirect");
    print(logInData.value.statusCode);
    Utils.savePreferenceValues(Constants.referenceId,
        "${logInData.value.data?.referenceId}"
    );
    Get.toNamed(RoutesClass.gotoVerifyScreen(), arguments: {
      'referenceId': logInData.value.data?.referenceId,
      "identity": emailController.value.text.isNotEmpty ? emailController.value.text : phoneController.value.text,
      if (phoneController.value.text.isNotEmpty) "countryCode": countryCode.value
    } );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
