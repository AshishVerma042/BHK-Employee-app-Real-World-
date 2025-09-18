import 'package:bhk_employee/Modules/model/artisanDetailsModel.dart';
import 'package:bhk_employee/Modules/model/artisanslistmodel.dart';
import 'package:bhk_employee/Modules/model/productDetailsModel.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../model/allProductListModel.dart';
import '../model/artisanProductListModel.dart';



class ArtisansListRepository {
  final _apiServices = NetworkApiServices();
  Future<ArtisansListModel> getartisanslistApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.artisanslist);
    return ArtisansListModel.fromJson(response);
  }
  Future<ArtisanProductListModel> getartisanproductlistApi(var Id) async {
    dynamic response = await _apiServices.getApi("${AppUrl.artisansproductlist}/$Id");
    return ArtisanProductListModel.fromJson(response);
  }
  Future<ArtisanDetailsModel> getartisansDetailsApi(var id) async {
    dynamic response = await _apiServices.getApi("${AppUrl.artisansdetails}/$id");
    return ArtisanDetailsModel.fromJson(response);
  }
  Future<ProductDetailsModel> getproductDetailsApi(var id) async {
    dynamic response = await _apiServices.getApi("${AppUrl.productdetails}/$id");
    return ProductDetailsModel.fromJson(response);
  }
  Future<AllProductListModel> getallproductlistApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.allProductlist);
    return AllProductListModel.fromJson(response);
  }
}
