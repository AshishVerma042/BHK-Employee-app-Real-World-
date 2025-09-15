
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
                                    Text(appStrings.artisansList, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
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
                                ? Center(
                                    child: Text(appStrings.noArtisansFound, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: Artisancontroller.getArtisanListModel.value.data?.docs?.length?? 0,
                                    itemBuilder: (context, index) {
                                      return  artisanDetailCard(
                                        Artisancontroller.getArtisanListModel.value.data?.docs?[index],
                                        onTap: ()  {
                                          final artisan = Artisancontroller.getArtisanListModel.value.data?.docs?[index];
                                          final artisanId = Artisancontroller.getArtisanListModel.value.data?.docs?[index].id;
                                          if (artisan != null) {
                                            Get.toNamed(RoutesClass.gotoArtisanProfileScreen(),arguments: {
                                              'artisan': artisan,
                                              'extraData': artisanId,
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
