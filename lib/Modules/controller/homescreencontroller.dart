import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Constants/utils.dart';
import '../../common/CommonMethods.dart';
import '../../common/common_widgets.dart';
import '../../common/map_geolocation/mapcontroller.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/allProductListModel.dart';
import '../repository/ArtisansRepository.dart';
import 'artisancontroller.dart';

class HomeScreenController extends GetxController {
  LocationController locationController = Get.put(LocationController());
  ArtisanController artisanController = Get.put(ArtisanController());


  var scrollController = ScrollController().obs;

  final _api = ArtisansListRepository();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final getAllProductListModel = AllProductListModel().obs;
  void setgetAllProductListModeldata(AllProductListModel value) => getAllProductListModel.value = value;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  final rxRequestStatus = Status.COMPLETED.obs;


  Future<void> getAllProductListApi() async {
    setRxRequestStatus(Status.LOADING);

    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      _api.getallproductlistApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setgetAllProductListModeldata(value);
        Utils.printLog("Response===> ${value.toString()}");
      }).onError((error, stackTrace) {
        handleApiError(error, stackTrace,
            setError: setError, setRxRequestStatus: setRxRequestStatus);
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }


  @override
  void onInit() {
    super.onInit();
    getAllProductListApi();
  }


  Future<void> artisansRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    getAllProductListApi();
    print("items.length");
  }


}