import 'dart:convert';

import 'package:bhk_employee/Constants/utils.dart';
import 'package:bhk_employee/common/commonmethods.dart';
import 'package:bhk_employee/data/response/status.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/routes/RoutesClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhk_employee/Modules/repository/logoutRepository.dart';

import '../../common/Constants.dart';
import '../model/getprofilemodel.dart';
import '../model/logoutmodel.dart';
import '../repository/profilerepository.dart';
import '../screens/login_screen.dart';
import 'commondashcontroller.dart';
import 'logincontroller.dart';

class ProfileController extends GetxController {
  CommonDashController commonDashController = Get.put(CommonDashController());
  final logoutrepository = LogoutRepository();

  profile(int index) {
    print(index);
    switch (index) {
      case 1: //MyOrders
        //commonDashController.selectedScreenIndex.value = 1;

        break;
      case 2: //Mystores
      // Get.toNamed(RoutesClass.gotoStoreScreen());

        break;

      case 3: //Notifications
        Get.toNamed(RoutesClass.gotoNotificationScreen());

        break;
      case 4:
        Get.toNamed(RoutesClass.gotoSettingScreen())?.then((onValue) {
          getProfileApi();
        });

        break;
    }
  }

  bool? isLogin;

  final repository = ProfileRepository();

  // Group Value for Radio Button.
  int indexs = 1;

  final logoutModel = LogoutModel().obs;
  void setLogoutdata(LogoutModel value) => logoutModel.value = value;

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  final getProfileModel = GetProfileModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setGetprofiledata(GetProfileModel value) =>
      getProfileModel.value = value;

  @override
  void onInit() {
    super.onInit();
    getProfileApi();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getProfileApi();
  }

  Future<void> getProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getprofileApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetprofiledata(value);
        CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
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

  Future<void> profileRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration(seconds: 2));
    // Update the list of items and refresh the UI
    getProfileApi();
    print("items.length");
  }
  Future<void> logOutApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      logoutrepository.logoutApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setLogoutdata(value);
        CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
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
  redirect() {
    Utils.savePreferenceValues(Constants.accessToken, "");
    Utils.savePreferenceValues(Constants.email, "");
    Utils.clearPreferenceValues();
    Get.delete<LoginController>();
    Get.offAll(() => LoginScreen());
  }


  Widget buildProfileOptionCard(String title, String subtitle, IconData icon, int index) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          leading: Icon(icon, color: Colors.brown[700]),
          title:
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          onTap: () {
            profile(index);
          },
        ),
        const Divider(
          height: 3,
          thickness: 0.25,
          endIndent: 0,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget logoutbuildProfileOptionCard(
      String title, String subtitle, IconData icon, int index) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          leading: Icon(icon, color: Colors.brown[700]),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          onTap: () {
            Get.dialog(
              AlertDialog(
                backgroundColor: Colors.orange.shade50,
                title: const Text("Confirm Logout"),
                content: const Text("Are you sure you want to log out?"),
                actions: [
                  InkWell(
                    onTap: ()=>Get.back(),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      logOutApi();
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 155, 105, 89),
                      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: const Text("Logout", style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            );
          },
        ),
        const Divider(
          height: 3,
          thickness: 0.25,
          endIndent: 0,
          color: Colors.black,
        ),
      ],
    );
  }
  Widget supportbuildProfileOptionCard(
      String title, String subtitle, IconData icon, int index) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          leading: Icon(icon, color: Colors.brown[700]),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
           onTap: () => Get.toNamed(RoutesClass.gotoSupport()),
        ),
        const Divider(
          height: 3,
          thickness: 0.25,
          endIndent: 0,
          color: Colors.black,
        ),
      ],
    );
  }
}
