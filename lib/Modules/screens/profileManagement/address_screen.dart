import 'package:bhk_employee/common/common_widgets.dart';
import 'package:bhk_employee/data/response/status.dart';
import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/resources/appconstants.dart';
import 'package:bhk_employee/resources/colors.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/map_geolocation/mapcontroller.dart';
import '../../../common/myUtils.dart';
import '../../controller/addresscontroller.dart';
import '../../controller/updateprofilecontroller.dart';

class AddressScreen extends ParentWidget {
  const AddressScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    AddressController controller = Get.put(AddressController());
    LocationController locationController = Get.put(LocationController());


    return
          Scaffold(
            backgroundColor:  Color.fromARGB(255, 247, 243, 233),
            appBar: AppBar(
              flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppConstants.customGradient)),
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              title: const Text("MANAGE ADDRESS", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),

            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [

                    ],
                  ),
                ),




              ],
            ),
            bottomNavigationBar:Padding(
              padding: const EdgeInsets.all(16.0),
              child: commonButton(
                double.infinity,
                45,
                appColors.brownDarkText,
                Colors.white,
                    () {
                  showAddAddressBottomSheet(context, controller,locationController,750);
                  locationController.getCurrentLocation();
                },
                hint: "Add Address",
                radius: 50,
              ),
            ),
          )
    ;
  }

  void showAddAddressBottomSheet(BuildContext context, AddressController controller,LocationController locationController, double h) {

    showModalBottomSheet(
      backgroundColor: appColors.backgroundColorSecond,
      context: context,
      isScrollControlled: true,
      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) {
        return Container(height: h,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, top: 20, left: 16, right: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_pin,color: Colors.brown,),
                        Text(
                          "Address Details",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
                        ),
                      ],
                    ),
                    InkWell(onTap: (){Get.back();},
                        child: Icon(Icons.close))
                  ],
                ),
                Divider(
                  color: Colors.black12,
                ),
                Text("Complete Address would Assist better \n in serving you...",style: TextStyle(color: Colors.black45 ),),

                Expanded(
                  child: SingleChildScrollView(

                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                         SizedBox(height: 16),


                        commonComponent("House/Flat/Building", commonTextField(controller.houseController.value, controller.houseFocusNode.value, double.infinity, (value) {}, hint: "Enter your House no.", fontSize: 14)),
                        12.kH,
                        commonComponent("Street/Area/Location", commonTextField(controller.streetController.value, controller.streetFocusNode.value, double.infinity, (value) {}, hint: "Enter your Street Address", fontSize: 14)),
                        12.kH,
                        commonComponent("LandMark", commonTextField(controller.landmarkController.value, controller.landmarkFocusNode.value, double.infinity, (value) {}, hint: "Enter your LandMark", fontSize: 14)),
                        12.kH,
                        commonComponent("City", commonTextField(controller.cityController.value, controller.cityFocusNode.value, double.infinity, (value) {}, hint: "${locationController.city.value}", readonly: true,  alwaysHint: true,fontSize: 14)),
                        12.kH,
                        commonComponent("State", commonTextField(controller.stateController.value, controller.stateFocusNode.value, double.infinity, (value) {}, hint: "${locationController.state.value}", readonly: true,alwaysHint: true,fontSize: 14)),
                        12.kH,
                        commonComponent("Country", commonTextField(controller.countryController.value, controller.countryFocusNode.value, double.infinity, (value) {}, hint: "${locationController.country.value}", readonly: true,alwaysHint: true,fontSize: 14)),
                        12.kH,
                        commonComponent("PinCode", commonTextField(controller.pincodeController.value, controller.pincodeFocusNode.value, double.infinity, (value) {}, hint: "${locationController.pincode.value}",readonly: true,alwaysHint: true, fontSize: 14)),
                        12.kH,
                        commonComponentRedStar("Address Type"),
                        12.kH,
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            addressType(Icons.home, "Home", controller),
                            addressType(Icons.card_travel, "Office", controller),
                            addressType(Icons.domain, "Other", controller),
                          ],
                        ),
                        12.kH,
                        Obx(() {
                          if (controller.selectedType.value.isNotEmpty) {
                            return Row(
                              children: [
                                Checkbox(
                                  value: controller.isDefaultAddress.value,
                                  activeColor: Colors.brown,
                                  checkColor: Colors.white,
                                  onChanged: (value) {
                                    controller.isDefaultAddress.value = value ?? false;
                                  },
                                ),
                                const Text("Set as default address"),
                              ],
                            );
                          } else {
                            return  SizedBox.shrink();
                          }
                        }),



                        SizedBox(height: 20),



                      ],
                    ),
                  ),
                ),
                commonButton(
                  double.infinity,
                  45,
                  appColors.brownDarkText,
                  Colors.white,
                      () {
                    if (controller.houseController.value.text.trim().isEmpty ||
                        controller.streetController.value.text.trim().isEmpty) {

                    } else {
                      controller.AddAddressApi(context);
                      Get.back();
                    }
                  },
                  hint: "Save Address",
                  radius: 50,
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget addressType(IconData icon, String title, AddressController controller) {
  return Obx(() {
    bool isSelected = controller.selectedType.value == title;

    return InkWell(
      onTap: () => controller.selectType(title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            width: 2,
            color: isSelected ?  Colors.brown : Colors.black45 ,
          ),
          // color: isSelected ? Colors.blue.shade50 : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ?  Colors.brown : Colors.black45),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ?  Colors.brown : Colors.black45,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  });
}
