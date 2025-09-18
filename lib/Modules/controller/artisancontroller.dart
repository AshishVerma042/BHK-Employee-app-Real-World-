//
// import 'package:get/get.dart';
//
// import '../../Constants/utils.dart';
// import '../../common/CommonMethods.dart';
// import '../../common/common_widgets.dart';
// import '../../data/response/status.dart';
// import '../../resources/strings.dart';
// import '../model/artisanslistmodel.dart';
// import '../repository/ArtisansRepository.dart';
//
//
// class ArtisanController extends GetxController{
//    final _api = ArtisansListRepository();
//
//    void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
//    final getArtisanListModel = ArtisansListModel().obs;
//    void setgetArtisanListModeldata(ArtisansListModel value) => getArtisanListModel.value = value;
//    void setError(String value) => error.value = value;
//    RxString error = ''.obs;
//    final rxRequestStatus = Status.COMPLETED.obs;
//
//
//    Future<void> getArtisanListApi() async {
//      setRxRequestStatus(Status.LOADING);
//
//      var connection = await CommonMethods.checkInternetConnectivity();
//      Utils.printLog("CheckInternetConnection===> ${connection.toString()}");
//
//      if (connection == true) {
//        _api.getartisanslistApi()
//            .then((value) {
//          setRxRequestStatus(Status.COMPLETED);
//          setgetArtisanListModeldata(value);
//          //CommonMethods.showToast(value.message);
//          Utils.printLog("Response===> ${value.toString()}");
//        })
//            .onError((error, stackTrace) {
//          handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
//        });
//      } else {
//        CommonMethods.showToast(appStrings.weUnableCheckData);
//      }
//    }
//
//
//    @override
//    void onInit() {
//      super.onInit();
//      getArtisanListApi();
//    }
//
//
//    Future<void> artisansRefresh() async {
//      await Future.delayed(Duration(seconds: 2));
//      getArtisanListApi();
//      print("items.length");
//    }
//
// }
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Constants/utils.dart';
import '../../common/CommonMethods.dart';
import '../../common/common_widgets.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/artisanslistmodel.dart';
import '../repository/ArtisansRepository.dart';

class ArtisanController extends GetxController {
  final _api = ArtisansListRepository();

  final getArtisanListModel = ArtisansListModel().obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  RxString error = ''.obs;

  var filteredArtisans = <Docs>[].obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setgetArtisanListModeldata(ArtisansListModel value) {
    getArtisanListModel.value = value;

    /// initialize filtered list with all artisans
    filteredArtisans.value = value.data?.docs ?? [];
  }

  void setError(String value) => error.value = value;

  Future<void> getArtisanListApi() async {
    setRxRequestStatus(Status.LOADING);

    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      _api.getartisanslistApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setgetArtisanListModeldata(value);
        Utils.printLog("Response===> ${value.toString()}");
      }).onError((error, stackTrace) {
        handleApiError(error, stackTrace,
            setError: setError, setRxRequestStatus: setRxRequestStatus);
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  /// 🔹 Filter function for search
  void filterArtisans(String query) {
    if (query.isEmpty) {
      filteredArtisans.value = getArtisanListModel.value.data?.docs ?? [];
    } else {
      filteredArtisans.value = (getArtisanListModel.value.data?.docs ?? [])
          .where((artisan) {
        final searchData =
            '${artisan.firstName ?? ""} ${artisan.lastName ?? ""} ${artisan.id ?? ""} ${artisan.expertizeField ?? ""}';
        return searchData.toLowerCase().contains(query.toLowerCase());
      })
          .toList();
    }
  }



  @override
  void onInit() {
    super.onInit();
    getArtisanListApi();
  }

  Future<void> artisansRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    getArtisanListApi();
    print("items.length");
  }
}
