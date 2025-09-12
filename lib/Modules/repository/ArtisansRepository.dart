import 'package:bhk_employee/Modules/model/artisanslistmodel.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
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
}
