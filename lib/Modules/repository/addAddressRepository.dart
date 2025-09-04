import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../model/addAddressModel.dart';


class AddAddressRepository {
  final _apiServices = NetworkApiServices();

  Future<AddAddressModel> addAddressApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.addaddress);
    return AddAddressModel.fromJson(response);
  }

}
