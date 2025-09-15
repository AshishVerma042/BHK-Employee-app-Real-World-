import 'dart:convert';

import 'package:bhk_employee/Modules/model/AddressUpdateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Constants/utils.dart';
import '../../common/CommonMethods.dart';
import '../../common/common_widgets.dart';
import '../../common/map_geolocation/mapcontroller.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../routes/RoutesClass.dart';
import '../model/AddressListModel.dart';
import '../model/addAddressModel.dart' hide Data;
import '../repository/addAddressRepository.dart';

class AddressController extends GetxController{

  final _api = AddAddressRepository();


  var selectedType = "Home".obs;
  var defaultType = "".obs;
  var isDefaultAddress = false.obs;
  var usedAddressTypes = <String>[].obs;

  void updateUsedTypes(List<Data> addresses) {
    usedAddressTypes.clear();
    usedAddressTypes.addAll(
      addresses.map((e) => e.addressType?.toLowerCase() ?? ""),
    );
  }




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

        "street": streetController.value.text.isEmpty ? locationController.place.first.street : streetController.value.text,
        "houseNo": houseController.value.text.isEmpty ? locationController.place.first.subLocality: houseController.value.text,
        "city": locationController.place.first.locality,
        "country": locationController.place.first.country,
        "state":locationController.place.first.administrativeArea,
        "postalCode": locationController.place.first.postalCode,
        "isDefault":isDefaultAddress.value,
        "addressType": selectedType.value,
        "longitude":locationController.longitude.value,
        "latitude":locationController.latitude.value,
        "landmark": landmarkController.value.text,
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




  final getaddressModel = AddressListModel().obs;
  void setgetAddressListModeldata(AddressListModel value) => getaddressModel.value = value;

  Future<void> getAddressListApi() async {
    setRxRequestStatus(Status.LOADING);

    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      _api.getaddresslistApi()
          .then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setgetAddressListModeldata(value);
        if (value.data != null) {
          updateUsedTypes(value.data!);
        }
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
      })
          .onError((error, stackTrace) {
        handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }


  final AddressUpdateData = AddressUpdateModel().obs;
  void setupdateAddressModeldata(AddressUpdateModel value) => AddressUpdateData.value = value;


  Future<void> AddressUpdateApi(context, id) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, dynamic> data = {
      if (houseController.value.text.isNotEmpty)
        "street": houseController.value.text,
      if (streetController.value.text.isNotEmpty)
        "houseNo": streetController.value.text,
      // if (landmarkController.value.text.isNotEmpty)
      //   "landmark": landmarkController.value.text,
      "city": locationController.place.first.locality,
      "country": locationController.place.first.country,
      "state":locationController.place.first.administrativeArea,
      "postalCode": locationController.place.first.postalCode,
      "isDefault":isDefaultAddress.value,
      "addressType": selectedType.value,
      "longitude":locationController.longitude.value,
      "latitude":locationController.latitude.value,
      "landmark": landmarkController.value.text,
    };
      var addressId = id;


    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      _api
          .updateAddressApi(data,  addressId )
          .then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setupdateAddressModeldata(value);
        CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        Get.offAllNamed(RoutesClass.gotoAddressScreen());


      }).onError((error, stackTrace) {
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
        Utils.printLog("Error===> ${stackTrace.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> deleteAddressApi(context,  id) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
        _api.deleteAddressApi(id).then((value) {
          setRxRequestStatus(Status.COMPLETED);
          setupdateAddressModeldata(value);
          CommonMethods.showToast(value.message);
          Utils.printLog("Response===> ${value.toString()}");


      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            CommonMethods.showToast(errorResponse['message']);
          } else {
            CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Delete Error===> ${error.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }




  @override
  void onInit() {
    super.onInit();
    getAddressListApi();
  }
}
