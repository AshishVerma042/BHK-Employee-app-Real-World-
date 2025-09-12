import 'package:bhk_employee/Modules/controller/commondashcontroller.dart';

import 'package:bhk_employee/common/myUtils.dart';
import 'package:bhk_employee/data/response/status.dart';
import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/resources/colors.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/common_widgets.dart';
import '../../../common/map_geolocation/mapcontroller.dart';
import '../../../resources/appconstants.dart';
import '../../../resources/images.dart';
import '../../../resources/strings.dart';
import '../../../routes/RoutesClass.dart';
import '../../controller/artisancontroller.dart';
import '../../controller/dashboardcontroller.dart';
import '../../controller/homescreencontroller.dart';
import '../artisanManagement/product_detail_page.dart';

class HomeScreen extends ParentWidget {
  const HomeScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    Dashboardcontroller controller = Get.put(Dashboardcontroller());
    ArtisanController Artisancontroller = Get.put(ArtisanController());
    LocationController locationController = Get.put(LocationController());
    HomeScreenController homeScreenController = Get.put(HomeScreenController());


    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: topAppBar(),
            backgroundColor: appColors.backgroundColor,
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: controller.dashboardRefresh,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(() => Row(
                        children: [
                          Icon(Icons.location_pin,color: Colors.redAccent,size: 22,),
                          Text(
                            locationController.location.value,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.brown),
                          ),
                        ],
                      )),
                    ),


                    collections(w, h, controller),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.kH,
                          // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text("Recently Added Artisans", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          //     InkWell(
                          //       onTap: () {
                          //         Get.find<CommonDashController>().selectedIndex.value = 1;
                          //       },
                          //       child: const Text("View All",style: TextStyle(fontSize: 14),),
                          //     ),
                          //
                          //   ],
                          // ),
                          // SizedBox(height: 4),
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   itemCount: controller.artisansItem.length,
                          //   itemBuilder: (context, index) {
                          //     return artisanCard(controller.artisansItem[index], Get.find<CommonDashController>());
                          //   },
                          // ),
                          Column(
                            children: [ Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(appStrings.recentlyAddedArtisans, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                InkWell(
                                  onTap: () {
                                    Get.find<CommonDashController>().selectedIndex.value = 1;
                                  },
                                  child: Text(appStrings.viewAll,style:  TextStyle(fontSize: 14),),
                                ),

                              ],
                            ),
                          (Artisancontroller.getArtisanListModel.value.data?.docs?.isEmpty ?? true)
                              ? SizedBox.shrink()
                              : ListView.builder(
                                      shrinkWrap: true,
                                       physics: NeverScrollableScrollPhysics(),
                                       itemCount: Artisancontroller.getArtisanListModel.value.data?.docs == null
                                           ? 0
                                           : (Artisancontroller.getArtisanListModel.value.data!.docs!.length > 5
                                           ? 5
                                           : Artisancontroller.getArtisanListModel.value.data!.docs!.length) ,
                                       itemBuilder: (context, index) {
                                  return artisanDetailCard(
                                    Artisancontroller.getArtisanListModel.value.data?.docs?[index],
                                    onTap: ()  {
                                    },
                                    onAddProduct: () {
                                      Get.toNamed(RoutesClass.gotoAddProductPage());
                                    },
                                  );

                                                              },
                                                            ),
                                ],
                              ),

                          20.kH,
                          Text(appStrings.recentlyAddedArtisansProducts, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          12.kH,
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.serviceItems.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.71),
                            itemBuilder: (context, index) {
                              return myProductCard(controller.serviceItems[index]);
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
          ),
          progressBarTransparentAnimationLoader(Artisancontroller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
        ],
      ),
    );
  }
}

Widget collections(double w, double h, Dashboardcontroller controller) {
  return Column(
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: controller.scrollController.value,
        child: Row(
          children: [
            cards(w, Colors.orange, Colors.orange[100]!, Icons.diversity_3_outlined, appStrings.totalArtisans, "0"),
            cards(w, Colors.blue, Colors.blue[100]!, Icons.how_to_reg_outlined, appStrings.approvedArtisans, "0"),
            cards(w, Colors.red, Colors.red[100]!, Icons.sensor_occupied_outlined, appStrings.pendingArtisans, "0"),
          ],
        ),
      ),

      2.kH,
    ],
  );
}

Widget cards(double w, Color color, Color lightColor, IconData icon, String title, String count) {
  return Container(
    margin: const EdgeInsets.all(12.0),
    width: w * 0.455,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: lightColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3))],
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
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ],
        ),
        16.kH,
        Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
          child: Text(
            count,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}



Widget artisanCard(Map<String, dynamic> list, CommonDashController commonDashController) {
  return Card(
    color: Colors.transparent,
    elevation: 0,
    margin: const EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1, color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
    shadowColor: Colors.black12,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,


        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(list['image']!, height: 50, width: 50, fit: BoxFit.cover),
          ),
          16.kW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${list['name']!}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black, ),
                ),
                4.kH,
                Text(
                  "${list['category']!}",
                  style: const TextStyle(fontSize: 14,  color: Colors.black, ),
                ),
                4.kH,
                Row(
                  children: [Icon(Icons.call,size: 16,color: Colors.black87,),
                    Text(
                       " ${list['phoneNo']!}",
                      style: const TextStyle(fontSize: 14, color: Colors.black87, ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

PreferredSizeWidget topAppBar(){
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppConstants.customGradient)),
    elevation: 0,
    automaticallyImplyLeading: true,
    iconTheme: const IconThemeData(color: Colors.white),
    toolbarHeight: 60,
    title: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( appStrings.goodMorning, style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
        Text(appStrings.user,  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    ),
    actions: [
      CircleAvatar(backgroundImage: AssetImage(AppImages.logo), radius: 20),
      const SizedBox(width: 16),
    ],
  );
}

