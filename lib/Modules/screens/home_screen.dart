import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/common_widgets.dart';
import '../../common/myUtils.dart';
import '../../data/response/status.dart';
import '../../main.dart';
import '../../resources/appconstants.dart';
import '../../resources/colors.dart';
import '../../resources/images.dart';
import '../../resources/strings.dart';
import '../../routes/RoutesClass.dart';
import '../controller/commondashcontroller.dart';
import '../controller/homescreencontroller.dart';
import 'artisanManagement/artisan_profile_screen.dart';
import 'artisanManagement/artisans.dart';

class HomeScreen extends ParentWidget {
  const HomeScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    HomeScreenController controller = Get.put(HomeScreenController());

    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: topAppBarHome(controller),
            backgroundColor: appColors.backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(16.0),
                    child: Obx(
                      () => Row(
                        children: [
                          Icon(Icons.location_pin, color: Colors.redAccent, size: 22),
                          Expanded(
                            child: Text(
                              controller.locationController.location.value,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: appColors.brown),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  collections(w, h, controller),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.kH,
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(appStrings.recentlyAddedArtisans, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                InkWell(
                                  onTap: () {
                                    Get.find<CommonDashController>().selectedIndex.value = 1;
                                  },
                                  child: Text(appStrings.viewAll, style: TextStyle(fontSize: 14)),
                                ),
                              ],
                            ),
                            (controller.artisanController.getArtisanListModel.value.data?.docs?.isEmpty ?? true)
                                ? Container(
                              height: Get.height * 0.44,
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  20.kH,
                                  Image.asset(AppImages.artisanIcon,scale: 9,fit: BoxFit.cover,),
                                  10.kH,
                                  Text(
                                    appStrings.noArtisansFound,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: appColors.brownDarkText,
                                    ),
                                  ),
                                  10.kH,
                                  Text(appStrings.noArtisansHaveBeenAdded,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  8.kH,
                                  commonButton(
                                    150,
                                    45,
                                    appColors.brownDarkText,
                                    appColors.white,
                                        () => Get.toNamed(RoutesClass.gotoRegistration()),
                                    hint: appStrings.addArtisan,
                                  )
                                ],
                              ),
                            )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.artisanController.getArtisanListModel.value.data?.docs == null ? 0
                                        : (controller.artisanController.getArtisanListModel.value.data!.docs!.length > 5 ? 5
                                        : controller.artisanController.getArtisanListModel.value.data!.docs!.length),
                                    itemBuilder: (context, index) {
                                      return artisanDetailCard(
                                        controller.artisanController.getArtisanListModel.value.data?.docs?[index],
                                        onTap: () {},
                                        onAddProduct: () {
                                          Get.toNamed(RoutesClass.gotoAddProductPage());
                                        },
                                      );
                                    },
                                  ),
                          ],
                        ),

                        20.kH,
                        (controller.artisanController.getArtisanListModel.value.data?.docs?.isEmpty ?? true)?
                        SizedBox.shrink()
                            :Text(appStrings.recentlyAddedArtisansProducts, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        12.kH,

                        (controller.getAllProductListModel.value.data?.docs?.isEmpty ?? true)?
                        Container(
                          height: Get.height * 0.34,
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              20.kH,
                              Text(
                                "No Product Found",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: appColors.brownDarkText,
                                ),
                              ),
                              10.kH,
                              Text(
                                "Start by adding your first Product to manage them here.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              20.kH,
                              commonButton(
                                150,
                                45,
                                appColors.brownDarkText,
                                Colors.white,
                                    () {
                                Get.toNamed(RoutesClass.gotoAddProductPage(), arguments:controller.artisanController.getArtisanListModel.value.data?.docs?[0].id);
                                },



                                hint: "Add Product",
                              )
                            ],
                          ),
                        )
                            :
                        GridView.builder(
                          shrinkWrap: true,
                          physics:  NeverScrollableScrollPhysics(),
                          itemCount: controller.getAllProductListModel.value.data?.docs?.length?? 0,
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.71),
                          itemBuilder: (context, index) {
                            return myProductCardReview(controller.getAllProductListModel.value.data?.docs?[index]);
                          },
                        ),
                        12.kH,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          progressBarTransparentAnimationLoader(controller.artisanController.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
        ],
      ),
    );
  }
}


Widget collections(double w, double h, HomeScreenController controller) {
  return Column(
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: controller.scrollController.value,
        child: Row(
          children: [
            cards(w, appColors.orange, appColors.orange[100]!, Icons.diversity_3_outlined, appStrings.totalArtisans, "0"),
            cards(w, appColors.blue, appColors.blue[100]!, Icons.how_to_reg_outlined, appStrings.approvedArtisans, "0"),
            cards(w, appColors.red, appColors.red[100]!, Icons.sensor_occupied_outlined, appStrings.pendingArtisans, "0"),
          ],
        ),
      ),

      2.kH,
    ],
  );
}

Widget cards(double w, Color color, Color lightColor, IconData icon, String title, String count) {
  return Container(
    margin:  EdgeInsets.all(12.0),
    width: w * 0.455,
    padding:  EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: lightColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: appColors.grayShad, blurRadius: 5, offset: const Offset(0, 3))],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: color.withValues(alpha: 0.2),
              child: Icon(icon, color: color, size: 17),
            ),
            8.kW,
            Text(
              title,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: appColors.black),
            ),
          ],
        ),
        16.kH,
        Padding(
          padding:  EdgeInsets.fromLTRB(5.0, 0, 0, 0),
          child: Text(
            count,
            style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: appColors.black),
          ),
        ),
      ],
    ),
  );
}



PreferredSizeWidget topAppBarHome(HomeScreenController controller) {
  return AppBar(
    flexibleSpace: Container(decoration: BoxDecoration(gradient: AppConstants.customGradient)),
    elevation: 0,
    automaticallyImplyLeading: true,
    iconTheme: IconThemeData(color: appColors.white),
    toolbarHeight: 60,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.getGreeting(),
          style: TextStyle(fontSize: 22, color: appColors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          appStrings.user,
          style: TextStyle(fontSize: 18, color: appColors.white, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    actions: [
      CircleAvatar(backgroundImage: AssetImage(AppImages.logo), radius: 20),
      16.kW
    ],
  );
}
