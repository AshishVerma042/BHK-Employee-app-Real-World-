import '../../data/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../model/artisanRegistrationModel.dart';
import '../model/verifyOtpModel.dart';

class RegistrationRepository {
  final _apiServices = NetworkApiServices();

  Future<ArtisanRegistrationModel> artisanRegistrationApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.artisanregistration);
    print(response);
    return ArtisanRegistrationModel.fromJson(response);
  }
  Future<VerifyOTPModel> verifyOtpApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.verifyOtp);
    return VerifyOTPModel.fromJson(response);
  }
}
