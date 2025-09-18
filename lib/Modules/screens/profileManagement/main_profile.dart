import 'package:bhk_employee/common/myUtils.dart';
import 'package:bhk_employee/data/response/status.dart';
import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/resources/images.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/routes/RoutesClass.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/appconstants.dart';
import '../../../resources/colors.dart';
import '../../controller/profilecontroller.dart';

class MainProfile extends ParentWidget {
  const MainProfile({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ProfileController controller = Get.put(ProfileController());
    return Obx(
          () =>
          Stack(
            children: [
              Scaffold(
                appBar: topAppBar(appStrings.profile),
                backgroundColor: appColors.backgroundColor,
                body: RefreshIndicator(
                  color: appColors.brown,
                  onRefresh: controller.profileRefresh,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment(0.0, 2.5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(70),
                                        child: controller.getProfileModel.value.data?.avatar?.isNotEmpty ?? false
                                            ? Image.network(
                                          controller.getProfileModel.value.data!.avatar!,
                                          width: 140,
                                          height: 140,
                                          fit: BoxFit.cover,
                                        )
                                            : Image.asset(
                                          AppImages.profile,
                                          width: 140,
                                          height: 140,
                                          fit: BoxFit.cover,
                                        ),
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
                            style: TextStyle(fontSize: 20, color: appColors.black, fontWeight: FontWeight.bold),
                          ),
                          5.kH,
                          Text(
                            "${controller.getProfileModel.value.data?.countryCode ?? ""} ${controller.getProfileModel.value.data?.phoneNo ?? ""}",
                            style: TextStyle(fontSize: 14, color: appColors.blackShade54, fontWeight: FontWeight.bold),
                          ),
                          10.kH,
                          ElevatedButton(
                            onPressed: () {
                              Get.toNamed(RoutesClass.gotoViewProfileScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColors.brownShade,
                              padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
                              foregroundColor: appColors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                            ),
                            child: Text(appStrings.viewProfile, style: TextStyle(color: appColors.white, fontSize: 12)),
                          ),
                          10.kH,
                        ],
                      ),

                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          children: [
                            controller.buildProfileOptionCard(appStrings.myAddress, appStrings.checkYourAddressDetails, Icons.location_pin, 1),

                            controller.buildProfileOptionCard(appStrings.settings, appStrings.editProfileManageYourProfile, Icons.settings_outlined, 4),

                            controller.logoutBuildProfileOptionCard(appStrings.logout, appStrings.logOutOfYourAccount, Icons.logout),

                            controller.buildProfileOptionCard(appStrings.support, appStrings.wereHereToHelp, Icons.headphones, 3),
                          ],
                        ),
                      ),

                      10.kH,
                    ],
                  ),
                ),
              ),

              progressBarTransparentAnimationLoader(controller.rxRequestStatus.value == Status.LOADING, h, w),
            ],
          ),
    );
  }
}

  PreferredSizeWidget topAppBar(String title) {
    return AppBar(
      flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppConstants.customGradient)),
      elevation: 0,
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: appColors.white),
      title: Text(
        title,
        style: TextStyle(fontSize: 23, color: appColors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
