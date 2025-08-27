


class LoginModel {
  String? email;
  int? contactNo;
  String? loginToken;
  int? userId;
  String? userName;
  String? groupName;
  int? statusCode;
  bool? success;

  LoginModel(
      {this.email,
        this.contactNo,
        this.loginToken,
        this.userId,
        this.userName,
        this.groupName,
        this.statusCode,
        this.success});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    contactNo = json['contact_no'];
    loginToken = json['login_token'];
    userId = json['user_id'];
    userName = json['user_name'];
    groupName = json['group_name'];
    statusCode = json['statusCode'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['login_token'] = this.loginToken;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['group_name'] = this.groupName;
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    return data;
  }
}
