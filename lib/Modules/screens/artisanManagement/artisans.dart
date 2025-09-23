
import 'package:bhk_employee/Modules/screens/artisanManagement/artisan_search_screen.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common_widgets.dart';
import '../../../common/myUtils.dart';
import '../../../data/response/status.dart';
import '../../../main.dart';
import '../../../resources/appconstants.dart';
import '../../../resources/colors.dart';
import '../../../routes/RoutesClass.dart';
import '../../controller/artisancontroller.dart';
import '../../controller/dashboardcontroller.dart';

class Artisans extends ParentWidget {
  const Artisans({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ArtisanController Artisancontroller = Get.put(ArtisanController());

    return Obx(
          () => Stack(
        children: [
          Scaffold(
                  appBar: AppBar(
                    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppConstants.customGradient)),
                    elevation: 0,
                    title: const Text(
                      'Artisans',
                      style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                    iconTheme: const IconThemeData(color: Colors.white),
                    actions: [Row(
                      children: [
                        InkWell(onTap: (){Get.to(ArtisanSearchScreen());},
                            child: Icon(Icons.search,color: Colors.white70)),
                        12.kW,
                      ],
                    )],
                  ),

                  backgroundColor: appColors.backgroundColor,

                  body: RefreshIndicator(
                    color: Colors.brown,
                    onRefresh: Artisancontroller.artisansRefresh,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 12.0,),
                      child: Column(
                        children: [

                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(appStrings.artisansList, style:  TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                                    InkWell(
                                      onTap: () {Get.toNamed(RoutesClass.gotoRegistration());
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.add, color: Colors.brown, size: 24.0),
                                          2.kW,
                                          Text(
                                            appStrings.addArtisan,
                                            style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child:  (Artisancontroller.getArtisanListModel.value.data?.docs?.isEmpty ?? true)
                                ? Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  20.kH,
                                  Image.asset('assets/images/icon1.png',scale: 9,fit: BoxFit.cover,),
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
                                  Text("No artisans have been added to your list. Click \n Add Artisan to get started.",
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
                                    itemCount: Artisancontroller.getArtisanListModel.value.data?.docs?.length?? 0,
                                    itemBuilder: (context, index) {
                                      return  artisanDetailCard(
                                        Artisancontroller.getArtisanListModel.value.data?.docs?[index],
                                        onTap: ()  {
                                          final artisanId = Artisancontroller.getArtisanListModel.value.data?.docs?[index].id;
                                          if (artisanId != null) {
                                            Get.toNamed(RoutesClass.gotoArtisanProfileScreen(),arguments: {
                                              'artisanId': artisanId,
                                            },   );
                                          }
                                        },


                                        onAddProduct: () {
                                          final artisanId = Artisancontroller.getArtisanListModel.value.data?.docs?[index].id;
                                           if (artisanId != null) {
                                             Get.toNamed(RoutesClass.gotoAddProductPage(), arguments:{ 'artisanId' :artisanId});
                                           }
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}




Widget skillCard(String skill) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    decoration: BoxDecoration(color: Colors.brown.shade50, borderRadius: BorderRadius.circular(20)),
    child: Text(
      skill,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.brown),
    ),
  );
}


Widget artisanDetailCard(dynamic artisan,{

  VoidCallback? onTap,
  VoidCallback? onAddProduct,
}) {
  return InkWell(
    onTap: onTap,

    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/Profile.png",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                12.kW,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              " ${artisan.firstName?? "Unknown"} ${artisan.lastName?? "Unknown"}",
                              style:  TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      4.kH,
                      Text(
                        "${artisan.expertizeField?? "Not Set"}",
                        style:  TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      6.kH,
                      Text(
                        "${appStrings.BHKEID} ${artisan.id?? 0000 }",
                        style:  TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                      6.kH,
                      Row(
                        children: [
                          Icon(Icons.phone, size: 14, color: Colors.black54),
                          4.kW,
                          Text(
                            "${artisan.countryCode?? "XX"} ${artisan.phoneNo?? "XXXXXXXXXX"}",
                            style:  TextStyle(fontSize: 13, color: Colors.black87),
                          ),
                        ],
                      ),
                      6.kH,
                      Text(
                        "${artisan.email?? "Not Set"}",
                        style:  TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ],
                  ),
                ),

                InkWell(
                  onTap: onAddProduct,
                  child: Container(padding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.brown, size: 19.0),
                        2.kW,
                        Text(
                          appStrings.addProduct,
                          style:  TextStyle(color: Colors.brown, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Wrap(
            //   spacing: 8,
            //   runSpacing: 4,
            //   children: List.generate(
            //     artisan['skills'].length,
            //     (index) => Container(
            //       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            //       decoration: BoxDecoration(color: Colors.brown.shade50, borderRadius: BorderRadius.circular(20)),
            //       child: Text(
            //         artisan['skills'][index],
            //         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.brown),
            //       ),
            //     ),
            //   ),
            // ),

            10.kH,

            // SizedBox(
            //   height: 30,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: artisan['skills'].length,
            //     itemBuilder: (context, index) {
            //       var skill = artisan['skills'][index];
            //       return Padding(
            //         padding: const EdgeInsets.only(right: 8.0),
            //         child: skillCard(skill),
            //       );
            //     },
            //   ),
            // ),


          ],
        ),
      ),
    ),
  );
}