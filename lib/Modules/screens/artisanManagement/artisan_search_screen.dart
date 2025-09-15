import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/resources/colors.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/common_widgets.dart';
import '../../../resources/appconstants.dart';
import '../../../routes/RoutesClass.dart';
import '../../controller/artisanSearchCoontroller.dart';
import '../../controller/artisancontroller.dart';
import '../../controller/artisanproductcontroller.dart';

class ArtisanSearchScreen extends ParentWidget {
  const ArtisanSearchScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ArtisanController Artisancontroller = Get.put(ArtisanController());
    ArtisanSearchController controller = Get.put(ArtisanSearchController());

    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: AppBar(
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppConstants.customGradient)),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Artisan Search",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            12.kH,
            TextField(
              onChanged: (value) {
                Artisancontroller.filterArtisans(value);
              },
              decoration: InputDecoration(
                hintText: appStrings.searchArtisans,
                hintStyle: TextStyle(color: appColors.contentPlaceholderPrimary, fontSize: 14),
                prefixIcon:  Icon(Icons.search, color: Colors.brown),
                filled: true,
                fillColor: appColors.cardBackground,
                contentPadding:  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: appColors.border, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: appColors.border, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.brown, width: 1.5),
                ),
              ),
            ),
            10.kH,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   itemCount: Artisancontroller.getArtisanListModel.value.data?.docs?.length,
                    //   itemBuilder: (context, index) {
                    //     return artisanDetailCard(
                    //       Artisancontroller.getArtisanListModel.value.data?.docs?[index],
                    //       onTap: ()  {
                    //         final artisanId = Artisancontroller.getArtisanListModel.value.data?.docs?[index].id;
                    //         if (artisanId != null) {
                    //           Get.toNamed(RoutesClass.gotoArtisanProfileScreen(),arguments: artisanId  );
                    //         }
                    //       },
                    //       onAddProduct: () {
                    //         Get.toNamed(RoutesClass.gotoAddProductPage());
                    //       },
                    //     );
                    //   },
                    // ),
                    Obx(() {
                      if (Artisancontroller.filteredArtisans.isEmpty) {
                        return SizedBox(width: w,height: h * 0.6 ,
                          child: Center(
                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search,size: 88,color: appColors.brownDarkText,),
                                Text(
                                  "No Artisans Found",
                                  style: TextStyle(color:  appColors.brownDarkText, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: Artisancontroller.filteredArtisans.length,
                        itemBuilder: (context, index) {
                          final artisan = Artisancontroller.filteredArtisans[index];
                          return artisanDetailCard(
                            artisan,
                            onTap: () {
                              final artisanId = artisan.id;
                              if (artisanId != null) {
                                Get.toNamed(
                                  RoutesClass.gotoArtisanProfileScreen(),
                                  arguments: artisanId,
                                );
                              }
                            },
                            onAddProduct: () {
                              Get.toNamed(RoutesClass.gotoAddProductPage());
                            },
                          );
                        },
                      );
                    }),


                  ],
                ),
              ),
            ),
           ],
        ),
      ),
    );
  }
}
