import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../model/addproductmodel.dart';
import '../model/getcategorymodel.dart';
import '../model/getsubcategorymodel.dart';

class AddProductRepository {
  final _apiServices = NetworkApiServices();

  Future<AddProductModel> addproductApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.addproduct);
    print(response);
    return AddProductModel.fromJson(response);
  }
  Future<GetCategoryModel> getcategoryApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.categorylist);
    return GetCategoryModel.fromJson(response);
  }
  Future<GetSubCategoryModel> getsubCategoryApi(var data) async {
    dynamic response = await _apiServices.getApi(AppUrl.subcategorylist);
    return GetSubCategoryModel.fromJson(response);
  }
}
