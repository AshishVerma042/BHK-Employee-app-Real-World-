

import 'package:bhk_employee/Modules/screens/artisanManagement/product_detail_page.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/common_widgets.dart';
import '../../../main.dart';
import '../../../resources/appconstants.dart';
import '../../../resources/colors.dart';
import '../../../routes/RoutesClass.dart';
import '../../controller/dashboardcontroller.dart';

class ArtisanProfileScreen extends ParentWidget {
  final Map<String, dynamic> artisan;
  const ArtisanProfileScreen({super.key, required this.artisan});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    Dashboardcontroller controller = Get.put(Dashboardcontroller());

    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 260,
                  decoration: const BoxDecoration(
                    gradient: AppConstants.customGradient,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),

                Positioned(
                  bottom: -190,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.only(
                                top: 70, left: 20, right: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: appColors.cardBackground,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  artisan['name'] ?? "Unknown",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                6.kH,
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.badge,
                                            size: 16,
                                            color: Colors.grey[700]),
                                        6.kW,
                                        Text("ID: ${artisan['id'] ?? 'ART000'}"),
                                      ],
                                    ),
                                    20.kW,
                                    Row(
                                      children: [
                                        Icon(Icons.person,
                                            size: 16,
                                            color: Colors.grey[700]),
                                        6.kW,
                                        Text(artisan['gender'] ?? "Female"),
                                      ],
                                    ),
                                  ],
                                ),
                                10.kH,
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.phone,
                                            size: 16, color: Colors.black54),
                                        6.kW,
                                        Text(artisan['phone'] ??
                                            "+91 0000000000"),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.email,
                                            size: 16, color: Colors.black54),
                                        6.kW,
                                        Text(artisan['email'] ??
                                            "example@gmail.com"),
                                      ],
                                    ),
                                  ],
                                ),
                                16.kH,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Expertise - ${artisan['expertize'] ?? "Handloom"}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                12.kH,
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Skills",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown.shade700,
                                    ),
                                  ),
                                ),
                                6.kH,
                                Text(
                                  artisan['skillsDesc'] ??
                                      "Beautifully crafted design, branding, and creative direction.",
                                  style:
                                  const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -50,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(padding: EdgeInsets.all(1),decoration: BoxDecoration(color: appColors.cardBackground,borderRadius: BorderRadius.all(Radius.circular(50))),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    "assets/images/Profile.png",
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // CircleAvatar(
                              //   radius: 55,
                              //   backgroundColor: appColors.cardBackground,
                              //   child: const CircleAvatar(
                              //     radius: 50,
                              //     backgroundImage:
                              //     AssetImage("assets/images/Profile.png"),
                              //   ),
                              // ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            210.kH,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Products",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            10.kH,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.serviceItems.length,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.70,
              ),
              itemBuilder: (context, index) {
                return myProductCard(controller.serviceItems[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget myProductCard(Map<String, dynamic> item, {bool isFavorite = false}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage(item['image']), fit: BoxFit.cover),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.check, size: 16, color: Colors.white),
                        SizedBox(width: 2),
                        Text("verified",
                            style:
                            TextStyle(fontSize: 10, color: Colors.white)),
                        SizedBox(width: 2),
                      ],
                    ),
                  ),
                  GestureDetector(
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
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 6,
              )
            ],
          ),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: Colors.grey, blurRadius: 5)
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.workspace_premium,
                        color: Colors.white70, size: 16),
                    Text(item['category'],
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70)),
                  ],
                ),
                Center(
                  child: commonButton(double.infinity, 35,
                      appColors.brownDarkText, Colors.white, () {Get.toNamed(RoutesClass.gotoProductDetailsScreen());},
                      hint: "Preview", fontSize: 15, radius: 50),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
