
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/myUtils.dart';
import '../../../data/response/status.dart';
import '../../../main.dart';
import '../../../resources/appconstants.dart';
import '../../../resources/colors.dart';
import '../../../routes/RoutesClass.dart';
import '../../controller/artisancontroller.dart';
import '../../controller/dashboardcontroller.dart';
import 'artisan_profile_screen.dart';

class Artisans extends ParentWidget {
  const Artisans({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ArtisanController Artisancontroller = Get.put(ArtisanController());
    Dashboardcontroller controller = Get.put(Dashboardcontroller());

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
                  ),
                  backgroundColor: appColors.backgroundColor,

                  body: RefreshIndicator(
                    color: Colors.brown,
                    onRefresh: Artisancontroller.artisansRefresh,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,),
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Artisans List", style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                                    InkWell(
                                      onTap: () {Get.toNamed(RoutesClass.gotoRegistration());
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.add, color: Colors.brown, size: 24.0),
                                          const SizedBox(width: 2),
                                          Text(
                                            "Add Artisan",
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
                                ? Center(
                                    child: Text("No artisans found", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: Artisancontroller.getArtisanListModel.value.data?.docs?.length?? 0,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          final artisanModel = Artisancontroller.getArtisanListModel.value.data?.docs?[index];
                                          // if (artisanModel != null) {
                                          //   final artisan = {
                                          //     "name": "${artisanModel.firstName ?? ''} ${artisanModel.lastName ?? ''}",
                                          //     "expertize": artisanModel.expertizeField ?? "Not Set",
                                          //     "id": artisanModel.id ?? "0000",
                                          //     "phone": "${artisanModel.countryCode ?? ''} ${artisanModel.phoneNo ?? ''}",
                                          //     "email": artisanModel.email ?? "Not Set",
                                          //
                                          //   };
                                          //   Get.to(() => ArtisanProfileScreen(artisan: artisan));
                                          // }

                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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

// Widget artisanCard(Map<String, dynamic> artisan) {
//   return InkWell(
//     onTap: () {
//       Get.to(() => ArtisanProfileScreen(artisan: artisan));
//     },
//     child: Container(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       decoration: BoxDecoration(
//         color: appColors.cardBackground,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 6,
//             offset: const Offset(0, 3), // shadow like Card
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: Image.asset(
//                     "assets/images/Profile.png",
//                     height: 60,
//                     width: 60,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: Text(
//                               artisan['name'] ?? "Unknown",
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         artisan['domain'] ?? "Handloom Textiles",
//                         style: const TextStyle(fontSize: 14, color: Colors.black54),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         "BHE ID: ${artisan['id'] ?? "ART000"}",
//                         style: const TextStyle(fontSize: 13, color: Colors.black87),
//                       ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           const Icon(Icons.phone, size: 14, color: Colors.black54),
//                           const SizedBox(width: 4),
//                           Text(
//                             artisan['phone'] ?? "+91 0000000000",
//                             style: const TextStyle(fontSize: 13, color: Colors.black87),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         "Products: ${artisan['noOfproduct'] ?? "0"}",
//                         style: const TextStyle(fontSize: 13, color: Colors.black87),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 InkWell(
//                     onTap: () {
//
//                       Get.toNamed(RoutesClass.gotoAddProductPage());
//                     }  ,
//                   child: Container(padding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(Icons.add, color: Colors.brown, size: 19.0),
//                         const SizedBox(width: 2),
//                         Text(
//                           "Add Product",
//                           style: const TextStyle(color: Colors.brown, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Wrap(
//             //   spacing: 8,
//             //   runSpacing: 4,
//             //   children: List.generate(
//             //     artisan['skills'].length,
//             //     (index) => Container(
//             //       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//             //       decoration: BoxDecoration(color: Colors.brown.shade50, borderRadius: BorderRadius.circular(20)),
//             //       child: Text(
//             //         artisan['skills'][index],
//             //         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.brown),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//
//             const SizedBox(height: 10),
//
//             SizedBox(
//               height: 30,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: artisan['skills'].length,
//                 itemBuilder: (context, index) {
//                   var skill = artisan['skills'][index];
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: skillCard(skill),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }


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
