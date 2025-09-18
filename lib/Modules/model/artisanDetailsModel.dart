class ArtisanDetailsModel {
  String? message;
  Data? data;

  ArtisanDetailsModel({this.message, this.data});

  ArtisanDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  Null? name;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? countryCode;
  Null? avatar;
  bool? isEmailVerified;
  bool? isPhoneNoVerified;
  String? roleName;
  String? userGroup;
  String? expertizeField;
  String? status;
  Null? aadhaarNumber;
  Null? latitude;
  Null? longitude;
  Null? subCaste;
  Null? userCasteCategory;
  Null? religion;
  Null? introVideo;
  String? createdAt;

  Data(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNo,
        this.countryCode,
        this.avatar,
        this.isEmailVerified,
        this.isPhoneNoVerified,
        this.roleName,
        this.userGroup,
        this.expertizeField,
        this.status,
        this.aadhaarNumber,
        this.latitude,
        this.longitude,
        this.subCaste,
        this.userCasteCategory,
        this.religion,
        this.introVideo,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    countryCode = json['countryCode'];
    avatar = json['avatar'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneNoVerified = json['isPhoneNoVerified'];
    roleName = json['roleName'];
    userGroup = json['user_group'];
    expertizeField = json['expertizeField'];
    status = json['status'];
    aadhaarNumber = json['aadhaarNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    subCaste = json['subCaste'];
    userCasteCategory = json['user_caste_category'];
    religion = json['religion'];
    introVideo = json['introVideo'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['countryCode'] = this.countryCode;
    data['avatar'] = this.avatar;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isPhoneNoVerified'] = this.isPhoneNoVerified;
    data['roleName'] = this.roleName;
    data['user_group'] = this.userGroup;
    data['expertizeField'] = this.expertizeField;
    data['status'] = this.status;
    data['aadhaarNumber'] = this.aadhaarNumber;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['subCaste'] = this.subCaste;
    data['user_caste_category'] = this.userCasteCategory;
    data['religion'] = this.religion;
    data['introVideo'] = this.introVideo;
    data['createdAt'] = this.createdAt;
    return data;
  }
}