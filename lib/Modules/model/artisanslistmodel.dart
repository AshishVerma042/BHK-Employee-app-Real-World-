class ArtisansListModel {
  String? message;
  Data? data;

  ArtisansListModel({this.message, this.data});

  ArtisansListModel.fromJson(Map<String, dynamic> json) {
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
  List<Docs>? docs;
  int? page;
  int? limit;
  int? totalDocs;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Data(
      {this.docs,
        this.page,
        this.limit,
        this.totalDocs,
        this.totalPages,
        this.hasNextPage,
        this.hasPrevPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(new Docs.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    totalDocs = json['totalDocs'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalDocs'] = this.totalDocs;
    data['totalPages'] = this.totalPages;
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    return data;
  }
}

class Docs {
  int? id;
  String? createdAt;
  Null? name;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  bool? isPhoneNoVerified;
  bool? isEmailVerified;
  String? countryCode;
  Null? avatar;
  Null? password;
  String? status;
  String? verifyStatus;
  String? roleName;
  String? userGroup;
  String? expertizeField;
  String? aadhaarNumber;
  Null? loginSource;
  Null? platform;
  Null? guestUserId;

  Docs(
      {this.id,
        this.createdAt,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNo,
        this.isPhoneNoVerified,
        this.isEmailVerified,
        this.countryCode,
        this.avatar,
        this.password,
        this.status,
        this.verifyStatus,
        this.roleName,
        this.userGroup,
        this.expertizeField,
        this.aadhaarNumber,
        this.loginSource,
        this.platform,
        this.guestUserId});

  Docs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    isPhoneNoVerified = json['isPhoneNoVerified'];
    isEmailVerified = json['isEmailVerified'];
    countryCode = json['countryCode'];
    avatar = json['avatar'];
    password = json['password'];
    status = json['status'];
    verifyStatus = json['verifyStatus'];
    roleName = json['roleName'];
    userGroup = json['user_group'];
    expertizeField = json['expertizeField'];
    aadhaarNumber = json['aadhaarNumber'];
    loginSource = json['loginSource'];
    platform = json['platform'];
    guestUserId = json['guestUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['isPhoneNoVerified'] = this.isPhoneNoVerified;
    data['isEmailVerified'] = this.isEmailVerified;
    data['countryCode'] = this.countryCode;
    data['avatar'] = this.avatar;
    data['password'] = this.password;
    data['status'] = this.status;
    data['verifyStatus'] = this.verifyStatus;
    data['roleName'] = this.roleName;
    data['user_group'] = this.userGroup;
    data['expertizeField'] = this.expertizeField;
    data['aadhaarNumber'] = this.aadhaarNumber;
    data['loginSource'] = this.loginSource;
    data['platform'] = this.platform;
    data['guestUserId'] = this.guestUserId;
    return data;
  }
}