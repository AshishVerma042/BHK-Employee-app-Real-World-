import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../common/common_widgets.dart';
import '../../../main.dart';
import '../../../resources/appconstants.dart';
import '../../../resources/colors.dart';
import '../../../routes/RoutesClass.dart';
import '../../controller/artisanprofile_controller.dart';
import 'VideoPlayerScreen.dart';

class ArtisanProfileScreen extends ParentWidget {
  const ArtisanProfileScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ArtisanProfileController controller = Get.put(ArtisanProfileController());

    return Obx(()
      => Scaffold(
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
                    top: 40,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -220,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              padding: EdgeInsets.only(
                                  top: 45, left: 20, right: 20, bottom: 20),
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
                                    // "${controller.getArtisanProductListModel.value.data?.docs?[0].artisan?.firstName ?? ""} ${controller.getArtisanProductListModel.value.data?.docs?[0].artisan?.lastName?? ""}",
                                    "${controller.getArtisanDetailModel.value.data?.firstName ?? ''} ${controller.getArtisanDetailModel.value.data?.lastName?? ''}",
                                    style:  TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  6.kH,
                                  Obx(() {
                                    final hasVideo = controller.introVideoFile.value != null;

                                    return GestureDetector(
                                      onTap: () {
                                        if (hasVideo) {
                                          Get.to(() => VideoPlayerScreen(), arguments: {
                                            'videoFile': controller.introVideoFile.value!
                                          });
                                        } else {

                                          bottomDrawerVideoFile(
                                            context,
                                            h * 0.25,
                                            w,
                                            controller.introVideoFile,
                                                () {
                                              pickVideoFromGallery(controller.introVideoFile, true);
                                            },
                                                () {
                                              pickVideoFromGallery(controller.introVideoFile, false);
                                            },
                                          );
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: appColors.backgroundColorSecond,
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: Colors.brown, width: 1.5),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.play_circle_fill, color: Colors.brown, size: 20),
                                            const SizedBox(width: 6),
                                            Text(
                                              hasVideo ? "Preview" : "Intro video",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.brown.shade800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),

                                  16.kH,
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
                                          Text(
                                            "BHKE ID: ${controller.getArtisanDetailModel.value.data?.id?? ''} ",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      20.kW,
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.email,
                                              size: 16, color: Colors.black54),
                                          6.kW,
                                          Text(
                                            "${controller.getArtisanDetailModel.value.data?.email?? ''}",
                                            style: TextStyle(fontSize: 14),
                                          ),
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
                                          Text(
                                            // "${controller.getArtisanProductListModel.value.data?.docs?[0].artisan?.countryCode?? "00"} ${controller.getArtisanProductListModel.value.data?.docs?[0].artisan?.phoneNo?? "00"}",
                                            "${controller.getArtisanDetailModel.value.data?.countryCode?? ''} ${controller.getArtisanDetailModel.value.data?.phoneNo?? ''}",
                                            style: TextStyle(fontSize: 14),
                                          ),
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
                                          const Icon(Icons.groups,
                                              size: 16, color: Colors.black54),
                                          6.kW,
                                          Text(
                                            "Caste",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.account_tree,
                                              size: 16, color: Colors.black54),
                                          6.kW,
                                          Text(
                                            "SubCaste",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  16.kH,
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            // controller.getArtisanProductListModel.value.data?.docs?[0].artisan?.expertizeField?? "00",
                                             "${controller.getArtisanDetailModel.value.data?.expertizeField}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                        ]),
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
                                    "Beautifully crafted design, branding, and creative direction.",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: -50,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      color: appColors.cardBackground,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
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
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.28),
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
              (controller.getArtisanProductListModel.value.data?.docs?.isEmpty ?? true)
                  ? Container(
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
                          () {  final artisanId = controller.artisanId;
                          if (artisanId != null) {
                            Get.toNamed(RoutesClass.gotoAddProductPage(), arguments:{ 'artisanId' :artisanId});
                          }},
                      hint: "Add Product",
                    )
                  ],
                ),
              )
                  : GridView.builder(
                shrinkWrap: true,
                physics:  NeverScrollableScrollPhysics(),
                itemCount:controller.getArtisanProductListModel.value.data?.docs?.length?? 0,
                padding:  EdgeInsets.all(16),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  return  myProductCardReview(controller.getArtisanProductListModel.value.data?.docs?[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget myProductCardReview(dynamic artisan, {bool isFavorite = false}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: (artisan?.images != null &&
            artisan!.images!.isNotEmpty &&
            (artisan.images![0].imageUrl?.isNotEmpty ?? false))
            ? CachedNetworkImageProvider(artisan.images![0].imageUrl!)
            : const AssetImage("assets/images/Product2.png") as ImageProvider,
        fit: BoxFit.cover,
      ),


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
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: artisan?.adminApprovalStatus== "PENDING"? Colors.brown.shade800 : Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                    ),
                    child: Row(
                      children: [
                        artisan?.adminApprovalStatus == "PENDING"
                            ?  SizedBox.shrink()
                            :  Icon(Icons.check, size: 14, color: Colors.white),
                        SizedBox(width: 2),
                        Text(artisan?.adminApprovalStatus?? "",
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,fontWeight: FontWeight.bold)),
                        SizedBox(width: 2),
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //     onTap: () {
                  //       isFavorite = !isFavorite;
                  //     },
                  //     child: Container(
                  //       padding: EdgeInsets.all(6),
                  //       decoration: BoxDecoration(
                  //         color: Colors.black.withOpacity(0.3),
                  //         shape: BoxShape.circle,
                  //       ),
                  //       child: Icon(
                  //         isFavorite? Icons.favorite : Icons.favorite_border,
                  //         color: isFavorite? Colors.red : Colors.white,
                  //         size: 18,
                  //       ),
                  //     ),
                  //   ),

                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
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
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        artisan?.productName?? "",
                        style: TextStyle(
                          fontSize: 14,
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
                 SizedBox(height: 2),
                Row(
                  children: [
                     Icon(Icons.workspace_premium,
                        color: Colors.white70, size: 14),
                    Text( artisan?.category?.categoryName?? "",
                        style:  TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70)),
                  ],
                ),
                Center(
                  child: commonButton(
                      double.infinity, 35, appColors.brownDarkText, Colors.white,
                          () {
                            final productId = artisan?.productId;
                            if (productId != null) {
                              Get.toNamed(RoutesClass.gotoProductDetailScreen(), arguments:{ 'productId' :productId});
                            }
                      },
                      hint: "Preview",
                      fontSize: 14,
                      radius: 50),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
