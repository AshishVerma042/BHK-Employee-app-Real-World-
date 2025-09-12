import 'package:bhk_employee/Modules/model/artisanslistmodel.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';


class ProductListRepository {
  final _apiServices = NetworkApiServices();
  Future<ArtisansListModel> getproductlistApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.artisanslist);
    return ArtisansListModel.fromJson(response);
  }
}
