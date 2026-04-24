import 'dart:convert';

import 'package:bhk_employee/Constants/utils.dart';
import 'package:get/get.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/getproductmodel.dart';
import '../repository/availableproductlist.dart';

class GetProductController extends GetxController {
  final repository = ProductRepository();

  final List<Map<String, dynamic>> serviceItems = [
    {
      'image': 'assets/images/ArticianImage1.jpg',
      'name': 'Wall Decorative',
      'category': 'Wall Decor',
      'price': 1200,
      'quality': 'Premium',
    },
    {
      'image': 'assets/images/ArticianImage8.jpg',
      'name': 'Clay Vase',
      'category': 'Clay Art',
      'price': 850,
      'quality': 'High',
    },
    {
      'image': 'assets/images/ArticianImage3.jpg',
      'name': 'Embroidered Cushion',
      'category': 'Textile Art',
      'price': 650,
      'quality': 'Premium',
    },
    {
      'image': 'assets/images/ArticianImage4.jpg',
      'name': 'Wooden Stool',
      'category': 'Woodcraft',
      'price': 1800,
      'quality': 'Standard',
    },
    {
      'image': 'assets/images/Product1.png',
      'name': 'Handwoven Carpet',
      'category': 'Handloom',
      'price': 3200,
      'quality': 'Luxury',
    },
  ];




  @override
  void onInit() {
    super.onInit();
    getProductApi();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   getProductApi();
  // }

  // Group Value for Radio Button.
  int indexs = 1;

  final rxRequestStatus = Status.COMPLETED.obs;
  final getProductData = GetProductModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  // void setAddProductnData(SignUpModel value) => addproductData.value = value;
  void setGetproductdata(GetProductModel value) =>
      getProductData.value = value;

  Future<void> productRefresh() async {

    await Future.delayed(Duration(seconds: 2));
    getProductApi();
    print("items.length");
  }

  Future<void> getProductApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getproductApi().then((value) {
        setGetproductdata(value);
        setRxRequestStatus(Status.COMPLETED);
        // print("set data===========>${GetProductModel.value.data?.docs?.length}");
        CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
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
}
