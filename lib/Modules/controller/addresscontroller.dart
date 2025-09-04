import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Constants/utils.dart';
import '../../common/CommonMethods.dart';
import '../../common/map_geolocation/mapcontroller.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/addAddressModel.dart';
import '../repository/addAddressRepository.dart';

class AddressController extends GetxController{

  final _api = AddAddressRepository();



  var selectedType = "".obs;
  var defaultType = "".obs;
  var isDefaultAddress = false.obs;
  // var usedAddressTypes = <String>[].obs;
  //
  // void updateUsedTypes(List<AddAddressModel> addresses) {
  //   usedAddressTypes.clear();
  //   usedAddressTypes.addAll(addresses.map((e) => e.addressType ?? ""));
  // }



  LocationController locationController = Get.put(LocationController());

  var houseController = TextEditingController().obs;
  var streetController = TextEditingController().obs;
  var landmarkController = TextEditingController().obs;
  var cityController = TextEditingController().obs;
  var stateController = TextEditingController().obs;
  var countryController = TextEditingController().obs;
  var pincodeController = TextEditingController().obs;
  var addresstypeController = TextEditingController().obs;


  var houseFocusNode = FocusNode().obs;
  var streetFocusNode = FocusNode().obs;
  var landmarkFocusNode = FocusNode().obs;
  var cityFocusNode = FocusNode().obs;
  var stateFocusNode = FocusNode().obs;
  var countryFocusNode = FocusNode().obs;
  var pincodeFocusNode = FocusNode().obs;
  var addresstypeFocusNode = FocusNode().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final addAddressData = AddAddressModel().obs;
  void setAddressData(AddAddressModel value) => addAddressData.value = value;


  Future<void> AddAddressApi(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "street": streetController.value.text,
        "houseNo": houseController.value.text,
        "city": locationController.city.value,
        "country": locationController.country.value,
        "state":locationController.state.value,
        "postalCode": locationController.pincode.value,
        "isDefault":false,
        "addressType": "OFFICE",
        "longitude":locationController.longitude.value,
        "latitude":locationController.latitude.value,
        "landmark":"Wave CITY"
      };
      Utils.printLog(data);
      _api
          .addAddressApi(data)
          .then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setAddressData(value);
        CommonMethods.showToast("${value.message}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
      })
          .onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            CommonMethods.showToast(errorResponse['message']);
          } else {
            CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }


  void selectType(String type) {
    selectedType.value = type;
  }

  void setDefault(String type) {
    defaultType.value = type;
  }

}
