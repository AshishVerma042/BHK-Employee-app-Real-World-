import 'package:bhk_employee/common/myUtils.dart';
import 'package:bhk_employee/data/response/status.dart';
import 'package:bhk_employee/resources/images.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/routes/RoutesClass.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/appconstants.dart';
import '../../../resources/colors.dart';
import '../../controller/profilecontroller.dart';

class MainProfile extends StatelessWidget {
  const MainProfile({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: topAppBar(),
            backgroundColor: appColors.backgroundColor,
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: controller.profileRefresh,
              child: Column(
                children: [
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Stack(
                          fit: StackFit.loose,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: const Alignment(0.0, 2.5),
                                  child: CircleAvatar(
                                    backgroundColor: Color.fromARGB(195, 250, 248, 238),
                                    backgroundImage: controller.getProfileModel.value.data?.avatar?.isNotEmpty ?? false
                                        ? NetworkImage(
                                            controller.getProfileModel.value.data?.avatar ?? "",
                                          )
                                        : AssetImage(AppImages.profile),
                                    radius: 70.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      20.kH,
                      Text(
                        controller.getProfileModel.value.data?.name ?? appStrings.user.toUpperCase(),
                        style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      5.kH,
                      Text(
                        "${controller.getProfileModel.value.data?.countryCode ?? ""} ${controller.getProfileModel.value.data?.phoneNo ?? ""}",
                        style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                      10.kH,
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(RoutesClass.gotoViewProfileScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 155, 105, 89),
                          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0), // Button background color
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                        ),
                        child: Text(appStrings.viewProfile, style: const TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                     10.kH,
                    ],
                  ),

                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      children: [
                        controller.buildProfileOptionCard(appStrings.myAddress, appStrings.checkYourAddressDetails, Icons.location_pin, 1),

                        controller.buildProfileOptionCard(appStrings.notifications, appStrings.viewYourNotifications, Icons.notifications, 1),

                        controller.buildProfileOptionCard(appStrings.settings, appStrings.editProfileManageYourProfile, Icons.settings_outlined, 4),

                        controller.logoutbuildProfileOptionCard(appStrings.logout, appStrings.logOutOfYourAccount, Icons.logout),

                        controller.buildProfileOptionCard(appStrings.support, appStrings.wereHereToHelp, Icons.headphones, 3),

                      ],
                    ),
                  ),

                  10.kH,
                ],
              ),
            ),
          ),

          progressBarTransparentAnimationLoader(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.height),
        ],
      ),
    );
  }
}

PreferredSizeWidget topAppBar() {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppConstants.customGradient)),
    elevation: 0,
    automaticallyImplyLeading: true,
    title: Text(
      appStrings.profile,
      style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
  );
}
