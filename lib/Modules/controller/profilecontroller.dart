import 'dart:convert';

import 'package:bhk_employee/Constants/utils.dart';
import 'package:bhk_employee/common/commonmethods.dart';
import 'package:bhk_employee/data/response/status.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/routes/RoutesClass.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
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
        Get.toNamed(RoutesClass.gotoAddressScreen());
        break;
      case 2: //Mystores
      // Get.toNamed(RoutesClass.gotoStoreScreen());

        break;

      case 3: //Support
        Get.toNamed(RoutesClass.gotoSupport());

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
    setRxRequestStatus(Status.LOADING);
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {

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
    setRxRequestStatus(Status.LOADING);
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {

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
      String title, String subtitle, IconData icon) {
    return Column(
      children: [
        ListTile(
          contentPadding:  EdgeInsets.symmetric(horizontal: 15),
          leading: Icon(icon, color: Colors.brown[700]),
          title: Text(title, style:  TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle,
              style:  TextStyle(fontSize: 12, color: Colors.grey)),
          onTap: () {
            Get.dialog(
              AlertDialog(
                insetPadding:  EdgeInsets.symmetric(horizontal: 80, vertical: 24),
                backgroundColor:Colors.white,
                title:  Row(
                  children: [
                     Icon(Icons.logout,color: Colors.brown,),
                    4.kW,
                    Text(appStrings.confirmLogout,style: TextStyle( fontWeight: FontWeight.bold,fontSize: 18),),
                  ],
                ),
                content:  Text(appStrings.areYouSureYou,style: TextStyle(fontSize: 12),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                actionsAlignment: MainAxisAlignment.start,
                actions: [
                  Column(
                    children: [
                      10.kH,
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: ()=>Get.back(),
                            child:  Text(appStrings.cancel,style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 155, 105, 89)),),
                          ),
                          InkWell(
                            onTap: (){logOutApi();},
                            child:  Text(appStrings.logout,style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 155, 105, 89)),),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     logOutApi();
                          //     },
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.white,
                          //     padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
                          //     foregroundColor: const Color.fromARGB(255, 155, 105, 89),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(18.0),
                          //     ),
                          //   ),
                          //   child:  Text(appStrings.logout, style: TextStyle(fontSize: 12)),
                          // ),
                        ],
                      ),
                    ],
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
}
