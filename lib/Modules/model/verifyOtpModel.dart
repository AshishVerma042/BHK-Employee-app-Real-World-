class VerifyOTPModel {
  String? message;
  Data? data;
  int? statusCode;
  bool? success;

  VerifyOTPModel({this.message, this.data, this.statusCode, this.success});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? accessToken;
  String? refreshToken;
  String? group;
  String? name;
  String? email;
  int? referenceId;

  Data(
      {this.accessToken,
      this.refreshToken,
      this.group,
      this.name,
      this.email,
      this.referenceId});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    group = json['group'];
    name = json['name'];
    email = json['email'];
    referenceId = json['referenceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['group'] = this.group;
    data['name'] = this.name;
    data['email'] = this.email;
    data['referenceId'] = this.referenceId;
    return data;
  }
}
