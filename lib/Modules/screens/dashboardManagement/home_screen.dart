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
import '../../../routes/RoutesClass.dart';
import '../../controller/artisancontroller.dart';
import '../../controller/dashboardcontroller.dart';
import '../artisanManagement/product_detail_page.dart';

class HomeScreen extends ParentWidget {
  const HomeScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    Dashboardcontroller controller = Get.put(Dashboardcontroller());
    ArtisanController Artisancontroller = Get.put(ArtisanController());
    LocationController locationController = Get.put(LocationController());


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
                          SizedBox(height: 20),
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
                                Text("Recently Added Artisans", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                InkWell(
                                  onTap: () {
                                    Get.find<CommonDashController>().selectedIndex.value = 1;
                                  },
                                  child: const Text("View All",style: TextStyle(fontSize: 14),),
                                ),

                              ],
                            ),
                          (Artisancontroller.getArtisanListModel.value.data?.docs?.isEmpty ?? true)
                              ? SizedBox.shrink()
                              : ListView.builder(
                                      shrinkWrap: true,
                                       physics: NeverScrollableScrollPhysics(),
                                       itemCount: 5,
                                       itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      // Get.to(() => ArtisanProfileScreen(artisan: artisan));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 8, ),
                                      decoration: BoxDecoration(
                                        color: appColors.cardBackground,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3), // shadow like Card
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
                                                const SizedBox(width: 12),

                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              " ${Artisancontroller.getArtisanListModel.value.data?.docs?[index].firstName?? "Unknown"} ${Artisancontroller.getArtisanListModel.value.data?.docs?[index].lastName?? "Unknown"}",
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w700,
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        "${Artisancontroller.getArtisanListModel.value.data?.docs?[index].expertizeField?? "Not Set"}",
                                                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Text(
                                                        "BHE ID: ${Artisancontroller.getArtisanListModel.value.data?.docs?[index].id?? 0000 }",
                                                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.phone, size: 14, color: Colors.black54),
                                                          const SizedBox(width: 4),
                                                          Text(
                                                            "${Artisancontroller.getArtisanListModel.value.data?.docs?[index].countryCode?? "XX"} ${Artisancontroller.getArtisanListModel.value.data?.docs?[index].phoneNo?? "XXXXXXXXXX"}",
                                                            style: const TextStyle(fontSize: 13, color: Colors.black87),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Text(
                                                        "${Artisancontroller.getArtisanListModel.value.data?.docs?[index].email?? "Not Set"}",
                                                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                InkWell(
                                                  onTap: () {

                                                    Get.toNamed(RoutesClass.gotoAddProductPage());
                                                  }  ,
                                                  child: Container(padding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.add, color: Colors.brown, size: 19.0),
                                                        const SizedBox(width: 2),
                                                        Text(
                                                          "Add Product",
                                                          style: const TextStyle(color: Colors.brown, fontSize: 14),
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

                                            const SizedBox(height: 10),

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

                                            progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.height),

                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                                              },
                                                            ),
                                ],
                              ),

                          SizedBox(height: 20),
                          Text("Recently Added Artisans Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 12),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.serviceItems.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.71),
                            itemBuilder: (context, index) {
                              return myProductCard(controller.serviceItems[index]);
                            },
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.height),
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
            cards(w, Colors.orange, Colors.orange[100]!, Icons.diversity_3_outlined, "Total Artisans", "0"),
            cards(w, Colors.blue, Colors.blue[100]!, Icons.how_to_reg_outlined, "Approved Artisans", "0"),
            cards(w, Colors.red, Colors.red[100]!, Icons.sensor_occupied_outlined, "Pending Artisans", "0"),
          ],
        ),
      ),

      SizedBox(height: 2),
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
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 16),
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${list['name']!}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black, ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${list['category']!}",
                  style: const TextStyle(fontSize: 14,  color: Colors.black, ),
                ),
                const SizedBox(height: 4),
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
        Text('Good Morning ', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
        Text("User",  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    ),
    actions: [
      CircleAvatar(backgroundImage: AssetImage(AppImages.logo), radius: 20),
      const SizedBox(width: 16),
    ],
  );
}
// Widget myProductCard(Map<String, dynamic> item, {bool isFavorite = false}) {
//   return Container(
//     width: double.infinity,
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.grey.shade500),
//       borderRadius: BorderRadius.circular(16),
//       color: Colors.transparent,
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child:  Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(16),
//                   bottom: Radius.circular(16),
//                 ),
//                 child: Image.asset(
//                   item['image'],
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//
//               /// ❤️ Heart icon at top-right
//               Positioned(
//                 top: 10,
//                 right: 10,
//                 child: GestureDetector(
//                   onTap: (){isFavorite= true;},
//                   child: Container(
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 6,
//                           offset: const Offset(2, 2),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       isFavorite ? Icons.favorite : Icons.favorite_border,
//                       color: isFavorite ? Colors.red : Colors.grey,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0, ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(item['category'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//                   Row(
//                     children: [
//                       const Icon(Icons.star, size: 14, color: Colors.orange),
//                       const SizedBox(width: 4),
//                       // Text(item['quality'], style: const TextStyle(fontSize: 14)),
//                       Text("10004", style: const TextStyle(fontSize: 14)),
//                     ],
//                   ),
//                 ],
//               ),
//               2.kH,
//
//               Text(
//                 item['name'],
//                 style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w600),
//               ),
//               2.kH,
//               // Text(
//               //   "₹${item['price']}",
//               //   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
//               // ),
//               Center(child: commonButton(120, 45, appColors.brownDarkText, Colors.white, (){},hint: "Preview")),
//               6.kH
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
Widget myProductCard(Map<String, dynamic> item, {bool isFavorite = false}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all( Radius.circular(16)),
                child: Image.asset(
                  item['image'],
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    isFavorite = !isFavorite;
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      SizedBox(width: 4),
                      Text("4.8", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 2),
              // Text(item['category'],
              //     style: const TextStyle(fontSize: 13, color: Colors.black54)),
              // const SizedBox(height: 2),
            
                  Row(
                    children: [Icon(Icons.workspace_premium,color: Colors.orangeAccent,size: 16,),
                      Text(item['category'],
                          style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),

              Center(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("₹${item['price']}",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
                  commonButton(
                    100,
                    30,
                    appColors.brownDarkText,
                    Colors.white,
                        () {
                          Get.to(() => ProductDetailScreen(product: item));
                          },
                    hint: "Preview",
                    fontSize: 12,
                    radius: 50,
                  )
                ],
              ))

            ],
          ),
        ),
      ],
    ),
  );
}
