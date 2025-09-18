import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import '../../Constants/utils.dart';
import '../../common/CommonMethods.dart';
import '../../common/common_widgets.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/productDetailsModel.dart';
import '../repository/ArtisansRepository.dart';

class ProductController extends GetxController {
  final _api = ArtisansListRepository();
  var currentIndex = 0.obs;
  final carouselController = CarouselSliderController();

  var imagesfetch = <String>[].obs;


  var productId = 0.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map;

    productId.value = int.tryParse(args['productId'].toString()) ?? 0;
    getArtisanDetailsApi();

  }


  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final rxRequestStatus = Status.COMPLETED.obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;




  final getProductDetailModel = ProductDetailsModel().obs;
  void setgetProductDetailsModeldata(ProductDetailsModel value) => getProductDetailModel.value = value;

  Future<void> getArtisanDetailsApi() async {
    setRxRequestStatus(Status.LOADING);

    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      _api.getproductDetailsApi(productId.value).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setgetProductDetailsModeldata(value);
        calculateTotalPrice();

        imagesfetch.clear();
        if (value.data?.images != null && value.data!.images!.isNotEmpty) {
          imagesfetch.addAll(
            value.data!.images!.map((img) => img.imageUrl ?? "").toList(),
          );
        }
        Utils.printLog("Response===> ${value.toString()}");
      }).onError((error, stackTrace) {
        handleApiError(error, stackTrace,
            setError: setError, setRxRequestStatus: setRxRequestStatus);
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

 final totalPrice = "".obs;

  void calculateTotalPrice() {
    double? price = double.tryParse(
      getProductDetailModel.value.data?.productPricePerPiece?.toString() ?? "",
    );

    double? unit = double.tryParse(
      getProductDetailModel.value.data?.quantity?.toString() ?? "",
    );

    if (price != null && unit != null) {
      totalPrice.value = (price * unit).toStringAsFixed(1);
    } else {
      totalPrice.value = "0.0";
    }
  }







}
