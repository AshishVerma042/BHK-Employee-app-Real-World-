import 'package:bhk_employee/data/app_url/app_url.dart';
import 'package:bhk_employee/data/network/network_api_services.dart';

import '../model/getproductmodel.dart';


class ProductRepository {
  final _apiServices = NetworkApiServices();

  Future<GetProductModel> getproductApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.availableproductlist);
    return GetProductModel.fromJson(response);
  }
}

