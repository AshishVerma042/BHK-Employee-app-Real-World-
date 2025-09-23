import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Constants/utils.dart';
import '../../common/CommonMethods.dart';
import '../../common/common_widgets.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/addproductmodel.dart';
import '../model/getcategorymodel.dart';
import '../model/getsubcategorymodel.dart';
import '../repository/addProductRepository.dart';

class AddProductController extends GetxController {
  var selectedIndex = 0.obs;
  final _api = AddProductRepository();


  var nameController = TextEditingController().obs;
  var timeController = TextEditingController().obs;
  var detaileddescriptionController = TextEditingController().obs;
  var netweightController = TextEditingController().obs;
  var quantityController = TextEditingController().obs;
  var materialController = TextEditingController().obs;
  var priceController = TextEditingController().obs;
  var careController = TextEditingController().obs;
  var lengthController = TextEditingController().obs;
  var breadthController = TextEditingController().obs;
  var heightController = TextEditingController().obs;
  var totalPriceController = TextEditingController().obs;
  var techniqueController = TextEditingController().obs;
  var patternController = TextEditingController().obs;

  var nameFocusNode = FocusNode().obs;
  var timeFocusNode = FocusNode().obs;
  var detaileddescriptionFocusNode = FocusNode().obs;
  var netweightFocusNode = FocusNode().obs;
  var quantityFocusNode = FocusNode().obs;
  var materialFocusNode = FocusNode().obs;
  var priceFocusNode = FocusNode().obs;
  var careFocusNode = FocusNode().obs;
  var lengthFocusNode = FocusNode().obs;
  var breadthFocusNode = FocusNode().obs;
  var heightFocusNode = FocusNode().obs;
  var totalPriceFocusNode = FocusNode().obs;
  var techniqueFocusNode = FocusNode().obs;
  var patternFocusNode = FocusNode().obs;

  var selectedcategoryid = Rxn<String>();

  var selectedsubcategoryid = Rxn<String>();

  var selectedWashCare = Rxn<String>();

  var selectedTexture = Rxn<String>();

  final RxList<ProductCategory> productCategories = <ProductCategory>[
    ProductCategory(categoryId: 1, categoryName: 'Handloom Sarees'),
    ProductCategory(categoryId: 2, categoryName: 'Cotton Fabric'),
    ProductCategory(categoryId: 3, categoryName: 'Silk Fabric'),
    ProductCategory(categoryId: 4, categoryName: 'Handmade Bags'),
    ProductCategory(categoryId: 5, categoryName: 'Wooden Crafts'),
    ProductCategory(categoryId: 6, categoryName: 'Terracotta Items'),
    ProductCategory(categoryId: 7, categoryName: 'Brassware'),
    ProductCategory(categoryId: 8, categoryName: 'Hand-painted Art'),
    ProductCategory(categoryId: 9, categoryName: 'Jute Products'),
    ProductCategory(categoryId: 10, categoryName: 'Bamboo & Cane Items'),
    ProductCategory(categoryId: 11, categoryName: 'Embroidery Work'),
    ProductCategory(categoryId: 12, categoryName: 'Macrame Crafts'),
    ProductCategory(categoryId: 13, categoryName: 'Woolen Shawls'),
    ProductCategory(categoryId: 14, categoryName: 'Block Printed Textiles'),
    ProductCategory(categoryId: 15, categoryName: 'Ceramic Pottery'),
    ProductCategory(categoryId: 16, categoryName: 'Handwoven Rugs'),
    ProductCategory(categoryId: 17, categoryName: 'Tribal Jewelry'),
  ].obs;

  var colorController = TextEditingController().obs;
  var colorFocusNode = FocusNode().obs;

  var sizeController = TextEditingController().obs;
  var sizeFocusNode = FocusNode().obs;

  var dropdownValues = 'gm'.obs;
  var dropdownValue = 'cm'.obs;

  bool gm = false;
  var clickNext = false.obs;

  var selectedColor = Rxn<String>();
  var selectedColorcheck = "blue".obs;

  var selectedSize = Rxn<String>();
  var selectedSizecheck = "xs".obs;

  var totalprice = 0.0.obs;

  final ImagePicker imgpicker = ImagePicker();
  var imagefiles = <String>[].obs;

  List<String> weights = ['gm', 'kg'];

  List<String> measureunits = ['cm', 'inches'];

  final List<String> washCareList = [
  "Hand Wash",
  "Machine Wash",
  "Dry Clean Only",
  "wipe with dry cloth",
  "wipe with damp cloth",
  "no washing required",
];

final List<String> textureList = [
  "Matte",
  "glossy",
  "hand-polished",
  "rough",
  "smooth",
];


  // void calculateSellingPrice() {
  //   double? mrp = double.tryParse(mrpController.value.text);
  //   double? discountPercentage = double.tryParse(discountController.value.text);

  //   if (mrp != null && discountPercentage != null) {
  //     double discountAmount = mrp * (discountPercentage / 100);
  //     sellingprice.value = mrp - discountAmount;
  //     sellingController.value.text = sellingprice.value.toStringAsFixed(2);
  //   }else if(mrp != null){
  //     sellingController.value.text = mrpController.value.text;
  //   }
  //   else {
  //     sellingprice.value = 0.0;
  //     sellingController.value.text = "0.0";
  //   }
  // }

  void calculateTotalPrice() {
    double? price = double.tryParse(priceController.value.text);
    double? unit = double.tryParse(quantityController.value.text);

    if (price != null && unit != null) {
      totalprice.value = price * unit;
      totalPriceController.value.text = totalprice.value.toStringAsFixed(2);
    }
    else {
      totalprice.value = 0.0;
      totalPriceController.value.text = "0.0";
    }
  }

  String getDimensions() {
    String length = lengthController.value.text;
    String breadth = breadthController.value.text;
    String height = heightController.value.text;
    String unit = dropdownValue.value.toString();

    if (length.isNotEmpty && breadth.isNotEmpty && height.isNotEmpty) {
      return '${length}x${breadth}x$height $unit';
    } else {
      return 'Please enter all dimensions';
    }
  }

  List<String> splitDimensions(String dimensions) {
    return dimensions.split(RegExp(r'[x\s]')).where((element) => element.isNotEmpty).toList();
  }

  String getWeight() {
    String weight = netweightController.value.text;
    String unit = dropdownValues.value.toString();

    if (weight.isNotEmpty) {
      return '$weight $unit';
    } else {
      return 'Please enter all Details';
    }
  }

  List<String> splitWeightAndUnit(String input) {
    return input.split(' ').where((element) => element.isNotEmpty).toList();
  }

  bool validateForm() {
    if((selectedcategoryid.value?.isNotEmpty??false)&&(selectedsubcategoryid.value?.isNotEmpty??false)&&(nameController.value.text.isNotEmpty)&&(detaileddescriptionController.value.text.isNotEmpty)&&(priceController.value.text.isNotEmpty)&&(materialController.value.text.isNotEmpty)&&(quantityController.value.text.isNotEmpty)&&(imagefiles.length>=10)) return true;
    return false;
  }
  var artisanId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map;
    totalPriceController.value.text = "0.0";
    getCategoryApi();
    artisanId.value = Get.arguments?? 0;
  }

  final rxRequestStatus = Status.COMPLETED.obs;

  final getSubcategoryModel = GetSubCategoryModel().obs;
  final addProductData = AddProductModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  final getCategoryModel = GetCategoryModel().obs;
  void setgetCategoryModeldata(GetCategoryModel value) => getCategoryModel.value = value;
  void setgetSubcategoryModeldata(GetSubCategoryModel value) => getSubcategoryModel.value = value;
  void setaddProductModeldata(AddProductModel value) => addProductData.value = value;

  Future<void> getCategoryApi() async {
    setRxRequestStatus(Status.LOADING);
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {

      _api.getcategoryApi()
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setgetCategoryModeldata(value);
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

  // Future<void> getSubCategoryApi() async {
  //   var connection = await CommonMethods.checkInternetConnectivity();
  //   Utils.printLog("CheckInternetConnection===> ${connection.toString()}");
  //
  //   if (connection == true) {
  //     setRxRequestStatus(Status.LOADING);
  //     _api.getsubCategoryApi(selectedcategoryid )
  //         .then((value) {
  //           setRxRequestStatus(Status.COMPLETED);
  //           setgetSubcategoryModeldata(value);
  //           Utils.printLog("Response===> ${value.toString()}");
  //         })
  //         .onError((error, stackTrace) {
  //           handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
  //         });
  //   } else {
  //     CommonMethods.showToast(appStrings.weUnableCheckData);
  //   }
  // }
  Future<void> getSubCategoryApi() async {
    setRxRequestStatus(Status.LOADING);

    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {

      _api.getsubCategoryApi(selectedcategoryid)
          .then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setgetSubcategoryModeldata(value);
        Utils.printLog("Response===> ${value.toString()}");
      })
          .onError((error, stackTrace) {
        handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> addProductApi( ) async {
    setRxRequestStatus(Status.LOADING);

    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {

      Map<String, String> data = {
        "product_name": nameController.value.text,
        "description": detaileddescriptionController.value.text,
        "categoryId": selectedcategoryid.value ?? "",
        "subCategoryId": selectedsubcategoryid.value ?? "",
        "productPricePerPiece": priceController.value.text,
        "quantity": quantityController.value.text,
        "material": materialController.value.text,
        "discount": "",
        if (netweightController.value.text.isNotEmpty) "netWeight": getWeight(),
        if (lengthController.value.text.isNotEmpty && breadthController.value.text.isNotEmpty && heightController.value.text.isNotEmpty) "dimension": getDimensions(),
        "color": "Brown",
        "size": "Large",
        "targetArtisanId":"${artisanId.value}",
        "images": imagefiles.join(","),
        "timeToMake": timeController.value.text,
        "texture": selectedTexture.value.toString(),
        "washCare": "${selectedWashCare.value}",
        "artUsed": techniqueController.value.text,
        "patternUsed": patternController.value.text,
        "adminRemarks": "nice product. try it once. ",


      };

      _api
          .addproductApi(data, imagefiles)
          .then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setaddProductModeldata(value);
        Utils.printLog("Response===> ${value.toString()}");
        Get.back();
        CommonMethods.showToast("Product Added Successfully...",);
      })
          .onError((error, stackTrace) {
        handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}

class ProductCategory {
  final int categoryId;
  final String categoryName;

  ProductCategory({required this.categoryId, required this.categoryName});
}
