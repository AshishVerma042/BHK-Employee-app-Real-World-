


import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/artisanslistmodel.dart' as artisanListModel;

class ArtisanProfileController extends GetxController {

  // final _api = ArtisansListRepository();



  // void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  // final getArtisanProductListModel = ArtisanProductListModel().obs;
  // void setgetArtisanProductListModeldata(ArtisanProductListModel value) => getArtisanProductListModel.value = value;
  // void setError(String value) => error.value = value;
  // RxString error = ''.obs;
  // final rxRequestStatus = Status.COMPLETED.obs;


  // Future<void> getArtisanProductListApi() async {
  //   setRxRequestStatus(Status.LOADING);
  //
  //   var connection = await CommonMethods.checkInternetConnectivity();
  //   Utils.printLog("CheckInternetConnection===> ${connection.toString()}");
  //
  //   if (connection == true) {
  //     _api.getartisanproductlistApi(artisanId.value)
  //         .then((value) {
  //       setRxRequestStatus(Status.COMPLETED);
  //       setgetArtisanProductListModeldata(value);
  //       //CommonMethods.showToast(value.message);
  //       Utils.printLog("Response===> ${value.toString()}");
  //     })
  //         .onError((error, stackTrace) {
  //       handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
  //     });
  //   } else {
  //     CommonMethods.showToast(appStrings.weUnableCheckData);
  //   }
  // }

  var introVideoFile = Rxn<File>();


  // var artisanId = "".obs;
  // @override
  // void onInit() {
  //   super.onInit();
  //   artisanId.value = (Get.arguments ?? "").toString();
  //   getArtisanProductListApi();
  // }
  var artisanData = Rxn<artisanListModel.Docs>();


  @override
  void onInit() {
    super.onInit();
    artisanData.value = Get.arguments as artisanListModel.Docs;  // 👈 correct type
  }

}
