class SignUpModel {
  String? message;
  Data? data;
  int? statusCode;
  bool? success;

  SignUpModel({this.message, this.data, this.statusCode, this.success});

  SignUpModel.fromJson(Map<String, dynamic> json) {
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
  int? referenceId;
  String? otp;

  Data({this.referenceId,this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    referenceId = json['referenceId'];
    otp = json['OTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referenceId'] = this.referenceId;
    data["OTP"] = this.otp;
    return data;
  }
}
