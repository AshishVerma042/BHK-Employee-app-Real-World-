class GetProfileModel {
  String? message;
  Data? data;

  GetProfileModel({this.message, this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? phoneNo;
  String? lastLogin;
  int? id;
  String? avatar;
  String? countryCode;
  bool? isEmailVerified;
  bool? isPhoneNoVerified;
  String? roleName;
  String? group;
  String? status;
  List<Addresses>? addresses;

  Data(
      {this.name,
      this.email,
      this.phoneNo,
      this.lastLogin,
      this.id,
      this.avatar,
      this.countryCode,
      this.isEmailVerified,
      this.isPhoneNoVerified,
      this.roleName,
      this.group,
      this.status,
      this.addresses});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    lastLogin = json['lastLogin'];
    id = json['id'];
    avatar = json['avatar'];
    countryCode = json['countryCode'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneNoVerified = json['isPhoneNoVerified'];
    roleName = json['roleName'];
    group = json['group'];
    status = json['status'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['lastLogin'] = this.lastLogin;
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['countryCode'] = this.countryCode;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isPhoneNoVerified'] = this.isPhoneNoVerified;
    data['roleName'] = this.roleName;
    data['group'] = this.group;
    data['status'] = this.status;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int? id;
  String? createdAt;
  bool? isDefault;
  String? street;
  String? houseNo;
  String? postalCode;
  String? city;
  String? country;
  String? state;
  String? addressType;

  Addresses(
      {this.id,
      this.createdAt,
      this.isDefault,
      this.street,
      this.houseNo,
      this.postalCode,
      this.city,
      this.country,
      this.state,
      this.addressType});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    isDefault = json['isDefault'];
    street = json['street'];
    houseNo = json['houseNo'];
    postalCode = json['postalCode'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    addressType = json['addressType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['isDefault'] = this.isDefault;
    data['street'] = this.street;
    data['houseNo'] = this.houseNo;
    data['postalCode'] = this.postalCode;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['addressType'] = this.addressType;
    return data;
  }
}
