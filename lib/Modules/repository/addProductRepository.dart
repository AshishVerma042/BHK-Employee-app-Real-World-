import '../../Constants/utils.dart';
import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../model/addproductmodel.dart';
import '../model/getcategorymodel.dart';
import '../model/getsubcategorymodel.dart';

class AddProductRepository {
  final _apiServices = NetworkApiServices();


  Future<GetCategoryModel> getcategoryApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.categorylist);
    return GetCategoryModel.fromJson(response);
  }
  Future<GetSubCategoryModel> getsubCategoryApi(var selectedCategory) async {
      dynamic response = await _apiServices.getApi("${AppUrl.subcategorylist}/$selectedCategory");
      return GetSubCategoryModel.fromJson(response);
  }
  Future<AddProductModel> addproductApi(var data, var path) async {
    dynamic response = await _apiServices.multiPartMediaApi(data, AppUrl.addproduct, path, "images");
    return AddProductModel.fromJson(response);
  }


}
