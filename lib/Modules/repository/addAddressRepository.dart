import 'package:bhk_employee/Modules/model/AddressUpdateModel.dart';

import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../model/AddressListModel.dart';
import '../model/addAddressModel.dart';


class AddAddressRepository {
  final _apiServices = NetworkApiServices();

  Future<AddAddressModel> addAddressApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.addaddress);
    return AddAddressModel.fromJson(response);
  }
  Future<AddressListModel> getaddresslistApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.addresslist);
    return AddressListModel.fromJson(response);
  }
  //
  // Future<UpdateProfileModel> updateProfileApi(var data, var path) async {
  //   dynamic response = await _apiServices.multiPartApi(
  //       data, AppUrl.updateprofile, path, "avatar");
  //   return UpdateProfileModel.fromJson(response);
  // }

  Future<AddressUpdateModel> updateAddressApi(var data, var id) async {
    dynamic response = await _apiServices.putApi(data , "${AppUrl.updateAddress}/$id");
    return AddressUpdateModel.fromJson(response);
  }

  Future<AddressUpdateModel> deleteAddressApi(var id) async {
    dynamic response = await _apiServices.deleteAddressApi("${AppUrl.deleteAddress}/$id");
    return AddressUpdateModel.fromJson(response);
  }



}
