


import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Constants/utils.dart';
import '../../common/CommonMethods.dart';
import '../../common/common_widgets.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/artisanProductListModel.dart';
import '../model/artisanslistmodel.dart' as artisanListModel;
import '../repository/ArtisansRepository.dart';

class ArtisanProfileController extends GetxController {

  final _api = ArtisansListRepository();



  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final getArtisanProductListModel = ArtisanProductListModel().obs;
  void setgetArtisanProductListModeldata(ArtisanProductListModel value) => getArtisanProductListModel.value = value;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  final rxRequestStatus = Status.COMPLETED.obs;


  Future<void> getArtisanProductListApi() async {
    setRxRequestStatus(Status.LOADING);

    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      _api.getartisanproductlistApi(artisanId.value)
          .then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setgetArtisanProductListModeldata(value);
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

  var introVideoFile = Rxn<File>();


  var artisanId = "".obs;
  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map;

    artisanId.value = args['artisanId']?? "";
     artisanData.value =args['artisan'];
    getArtisanProductListApi();
  }
   var artisanData = Rxn<artisanListModel.Docs>();



}
