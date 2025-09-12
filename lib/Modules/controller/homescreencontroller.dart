import 'package:get/get.dart';
import '../../Constants/utils.dart';
import '../../common/CommonMethods.dart';
import '../../common/common_widgets.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/artisanslistmodel.dart';
import '../repository/ArtisansRepository.dart';

class HomeScreenController extends GetxController {
  final _api = ArtisansListRepository();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final getArtisanListModel = ArtisansListModel().obs;
  void setgetArtisanListModeldata(ArtisansListModel value) => getArtisanListModel.value = value;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  final rxRequestStatus = Status.COMPLETED.obs;


  Future<void> getArtisanListApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      _api.getartisanslistApi()
          .then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setgetArtisanListModeldata(value);
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


  @override
  void onInit() {
    super.onInit();
    getArtisanListApi();
  }


  Future<void> artisansRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    getArtisanListApi();
    print("items.length");
  }


}