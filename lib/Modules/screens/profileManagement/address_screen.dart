import 'package:bhk_employee/common/common_widgets.dart';
import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/resources/appconstants.dart';
import 'package:bhk_employee/resources/colors.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/map_geolocation/mapcontroller.dart';
import '../../../common/myUtils.dart';
import '../../../data/response/status.dart';
import '../../controller/addresscontroller.dart';

class AddressScreen extends ParentWidget {
  const AddressScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    AddressController controller = Get.put(AddressController());
    LocationController locationController = Get.put(LocationController());

    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: Color.fromARGB(255, 247, 243, 233),
            appBar: AppBar(
              flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppConstants.customGradient)),
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              title: Text(appStrings.manageAddress.toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
            ),

            body: Obx(
              () => (controller.getaddressModel.value.data?.isEmpty ?? true)
                  ? Center(
                      child: Text(
                        "No Address Found",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemCount: controller.getaddressModel.value.data?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: appColors.cardBackground,
                              boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 5)],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          controller.getaddressModel.value.data?[index].addressType?.toLowerCase() == "home"
                                              ? Icons.home
                                              : controller.getaddressModel.value.data?[index].addressType?.toLowerCase() == "office"
                                              ? Icons.business_center
                                              : Icons.domain,
                                          color: Colors.brown,
                                          size: 22,
                                        ),
                                        6.kW,
                                        Text(
                                          "${controller.getaddressModel.value.data?[index].addressType?.toLowerCase() == "office"? "Work": controller.getaddressModel.value.data?[index].addressType}",
                                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 14),
                                        ),
                                        6.kW,
                                        if (controller.getaddressModel.value.data?[index].isDefault == true)
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(width: 1.2, color: Colors.black45),
                                            ),
                                            child: Text(
                                              appStrings.Default,
                                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black45),
                                            ),
                                          ),
                                      ],
                                    ),
                                    PopupMenuButton(
                                      color: appColors.backgroundColorSecond,
                                      offset: Offset(0, 40),
                                      icon: Icon(Icons.more_vert, color: Colors.brown),
                                      onSelected: (value) {
                                        if (value == 'edit') {
                                        } else if (value == 'delete') {

                                        }
                                      },
                                      itemBuilder: (BuildContext context) => [
                                        PopupMenuItem(
                                          onTap: () {
                                            showUpdateAddressBottomSheet(context, controller, locationController, 750, index);
                                          },
                                          value: 'edit',
                                          child: Text("Edit", style: TextStyle(color: Colors.brown)),
                                        ),
                                        PopupMenuItem(
                                          onTap: (){
                                            controller.deleteAddressApi(context,"${controller.getaddressModel.value.data?[index].id ?? ""}");
                                          },
                                          value: 'delete',
                                          child: Text("Delete", style: TextStyle(color: Colors.brown)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Text(
                                    "${controller.getaddressModel.value.data?[index].houseNo ?? ""}, ${controller.getaddressModel.value.data?[index].street ?? ""} ${controller.getaddressModel.value.data?[index].landmark ?? ""}, ${controller.getaddressModel.value.data?[index].state ?? ""}, ${controller.getaddressModel.value.data?[index].country ?? ""}, ${controller.getaddressModel.value.data?[index].state ?? ""}, ${controller.getaddressModel.value.data?[index].postalCode ?? ""}",
                                    style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
            bottomNavigationBar: (controller.getaddressModel.value.data?.isEmpty ?? true)
                ? Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 22),
                    child: commonButton(
                      double.infinity,
                      45,
                      appColors.brownDarkText,
                      Colors.white,
                      () {
                        showAddAddressBottomSheet(context, controller, locationController, 750);
                        locationController.getCurrentLocation();
                      },
                      hint: "Add Address",
                      radius: 50,
                    ),
                  )
                : null,

            floatingActionButton: (controller.getaddressModel.value.data?.isNotEmpty ?? false)
                ? Padding(
                  padding:  EdgeInsets.only(bottom: 18.0,right: 10),
                  child: FloatingActionButton(
                      backgroundColor: appColors.brownDarkText,
                      onPressed: () {
                        showAddAddressBottomSheet(context, controller, locationController, 750);
                        locationController.getCurrentLocation();
                      },
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                )
                : null,
          ),
          progressBarTransparentAnimationLoader(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
        ],
      ),
    );
  }

  void showAddAddressBottomSheet(BuildContext context, AddressController controller, LocationController locationController, double h) {

    showModalBottomSheet(
      backgroundColor: appColors.backgroundColorSecond,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) {
        return Container(
          height: h,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, top: 20, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                16.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_pin, color: Colors.brown),
                        Text("Address Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                Divider(color: Colors.black12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Text("Complete Address would Assist better \n in serving you...", style: TextStyle(color: Colors.black45, fontSize: 12)),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        16.kH,

                        commonComponent(
                          "House/Flat/Building",
                          commonTextField(controller.houseController.value, controller.houseFocusNode.value, double.infinity, (value) {}, hint: locationController.place.isNotEmpty ? locationController.place.first.street ?? "" : "Enter House/Flat/Building", fontSize: 14),
                        ),
                        12.kH,
                        commonComponent(
                          "Street/Area/Location",
                          commonTextField(controller.streetController.value, controller.streetFocusNode.value, double.infinity, (value) {}, hint: locationController.place.isNotEmpty ? locationController.place.first.subLocality ?? "" : "Enter Street/Area/Location", fontSize: 14),
                        ),
                        12.kH,
                        commonComponent("LandMark", mandatory: false, commonTextField(controller.landmarkController.value, controller.landmarkFocusNode.value, double.infinity, (value) {}, hint: "Enter your LandMark", fontSize: 14)),
                        12.kH,
                        commonComponent(
                          "City",
                          mandatory: false,
                          commonTextField(controller.cityController.value, controller.cityFocusNode.value, double.infinity, (value) {}, hint: locationController.place.isNotEmpty ? locationController.place.first.locality ?? "" : "Enter City", readonly: true, alwaysHint: true, fontSize: 14),
                        ),
                        12.kH,
                        commonComponent(
                          "State",
                          mandatory: false,
                          commonTextField(
                            controller.stateController.value,
                            controller.stateFocusNode.value,
                            double.infinity,
                            (value) {},
                            hint: locationController.place.isNotEmpty ? locationController.place.first.administrativeArea ?? "" : "Enter State",
                            readonly: true,
                            alwaysHint: true,
                            fontSize: 14,
                          ),
                        ),
                        12.kH,
                        commonComponent(
                          "Country",
                          mandatory: false,
                          commonTextField(controller.countryController.value, controller.countryFocusNode.value, double.infinity, (value) {}, hint: locationController.place.isNotEmpty ? locationController.place.first.country ?? "" : "Enter Country", readonly: true, alwaysHint: true, fontSize: 14),
                        ),
                        12.kH,
                        commonComponent(
                          "PinCode",
                          mandatory: false,
                          commonTextField(
                            controller.pincodeController.value,
                            controller.pincodeFocusNode.value,
                            double.infinity,
                            (value) {},
                            hint: locationController.place.isNotEmpty ? locationController.place.first.postalCode ?? "" : "Enter PinCode",
                            readonly: true,
                            alwaysHint: true,
                            fontSize: 14,
                          ),
                        ),
                        12.kH,
                        commonComponentRedStar("Address Type"),
                        12.kH,
                        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [addressType(Icons.home, "Home", controller), addressType(Icons.business_center, "Office", controller), addressType(Icons.domain, "Others", controller)]),
                        12.kH,
                        Obx(
                          () => Row(
                            children: [
                              Checkbox(
                                value: controller.isDefaultAddress.value,
                                activeColor: Colors.brown,
                                checkColor: Colors.white,
                                onChanged: (value) {
                                  controller.isDefaultAddress.value = value ?? false;
                                },
                              ),
                              Text("Mark as default address"),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: commonButton(
                    double.infinity,
                    45,
                    appColors.brownDarkText,
                    Colors.white,
                    () {
                      // if (controller.houseController.value.text.trim().isEmpty ||
                      //     controller.streetController.value.text.trim().isEmpty) {
                      //
                      // } else {
                      controller.AddAddressApi(context);
                      Get.back();
                      // }
                    },
                    hint: "Save Address",
                    radius: 50,
                  ),
                ),

                10.kH,
              ],
            ),
          ),
        );
      },
    );
  }
}

void showUpdateAddressBottomSheet(BuildContext context, AddressController controller, LocationController locationController, double h, int index) {
  showModalBottomSheet(
    backgroundColor: appColors.backgroundColorSecond,
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    builder: (context) {
      return Container(
        height: h,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20, top: 20, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                ),
              ),
              16.kH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: Colors.brown),
                      Text("Address Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              Divider(color: Colors.black12),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Text("Complete Address would Assist better \n in serving you...", style: TextStyle(color: Colors.black45, fontSize: 12)),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      16.kH,

                      commonComponent("House/Flat/Building", commonTextField((controller.houseController.value ==controller.getaddressModel.value.data?[index].houseNo) as TextEditingController, controller.houseFocusNode.value, double.infinity, (value) {}, hint: "${controller.getaddressModel.value.data?[index].houseNo}", fontSize: 14)),
                      12.kH,
                      commonComponent("Street/Area/Location", commonTextField(controller.streetController.value, controller.streetFocusNode.value, double.infinity, (value) {}, hint: "${controller.getaddressModel.value.data?[index].street}", fontSize: 14)),
                      12.kH,
                      commonComponent("LandMark", mandatory: false, commonTextField(controller.landmarkController.value, controller.landmarkFocusNode.value, double.infinity, (value) {}, hint: "${controller.getaddressModel.value.data?[index].landmark}", fontSize: 14)),
                      12.kH,
                      commonComponent("City", mandatory: false, commonTextField(controller.cityController.value, controller.cityFocusNode.value, double.infinity, (value) {}, hint: "${controller.getaddressModel.value.data?[index].city}", readonly: true, alwaysHint: true, fontSize: 14)),
                      12.kH,
                      commonComponent("State", mandatory: false, commonTextField(controller.stateController.value, controller.stateFocusNode.value, double.infinity, (value) {}, hint: "${controller.getaddressModel.value.data?[index].state}", readonly: true, alwaysHint: true, fontSize: 14)),
                      12.kH,
                      commonComponent("Country", mandatory: false, commonTextField(controller.countryController.value, controller.countryFocusNode.value, double.infinity, (value) {}, hint: "${controller.getaddressModel.value.data?[index].country}", readonly: true, alwaysHint: true, fontSize: 14)),
                      12.kH,
                      commonComponent("PinCode", mandatory: false, commonTextField(controller.pincodeController.value, controller.pincodeFocusNode.value, double.infinity, (value) {}, hint: "${controller.getaddressModel.value.data?[index].postalCode}", readonly: true, alwaysHint: true, fontSize: 14)),
                      12.kH,
                      commonComponentRedStar("Address Type"),
                      12.kH,
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [addressType(Icons.home, "Home", controller), addressType(Icons.business_center, "Work", controller), addressType(Icons.domain, "Others", controller)]),
                      12.kH,
                      Obx(
                        () => Row(
                          children: [
                            Checkbox(
                              value: controller.isDefaultAddress.value,
                              activeColor: Colors.brown,
                              checkColor: Colors.white,
                              onChanged: (value) {
                                controller.isDefaultAddress.value = value ?? false;
                              },
                            ),
                            Text("Mark as default address"),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: commonButton(
                  double.infinity,
                  45,
                  appColors.brownDarkText,
                  Colors.white,
                  () {
                    // if (controller.houseController.value.text.trim().isEmpty ||
                    //     controller.streetController.value.text.trim().isEmpty) {
                    //
                    // } else {
                    controller.AddressUpdateApi(context, controller.getaddressModel.value.data?[index].id);
                    Get.back();
                    // }
                  },
                  hint: "Update Address",
                  radius: 50,
                ),
              ),

              10.kH,
            ],
          ),
        ),
      );
    },
  );
}
Widget addressType(IconData icon, String title, AddressController controller) {
  return Obx(() {
    bool isSelected = controller.selectedType.value == title;
    bool isDisabled = controller.usedAddressTypes.contains(title.toLowerCase());

    return InkWell(
      onTap: isDisabled ? null : () => controller.selectType(title),
      child: Opacity(
        opacity: isDisabled ? 0.4 : 1.0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              width: 2,
              color: isSelected ? Colors.brown : Colors.black45,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? Colors.brown : Colors.black45),
              6.kW,
              Text(
                title=="Office"? "Work": title,
                style: TextStyle(
                  color: isDisabled
                      ? Colors.grey
                      : isSelected
                      ? Colors.brown
                      : Colors.black45,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}
