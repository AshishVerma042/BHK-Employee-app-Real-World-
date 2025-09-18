class AllProductListModel {
  String? message;
  Data? data;

  AllProductListModel({this.message, this.data});

  AllProductListModel.fromJson(Map<String, dynamic> json) {
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
  bool? hasNextPage;
  bool? hasPrevPage;
  int? limit;
  int? page;
  int? totalDocs;
  int? totalPages;

  Data(
      {this.docs,
        this.hasNextPage,
        this.hasPrevPage,
        this.limit,
        this.page,
        this.totalDocs,
        this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(new Docs.fromJson(v));
      });
    }
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
    limit = json['limit'];
    page = json['page'];
    totalDocs = json['totalDocs'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['totalDocs'] = this.totalDocs;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Docs {
  int? productId;
  String? bhkProductId;
  String? productName;
  String? description;
  String? productPricePerPiece;
  int? quantity;
  String? material;
  int? discount;
  String? netWeight;
  String? dimension;
  List<dynamic>? color;
  List<dynamic>? size;
  String? productStatus;
  String? adminApprovalStatus;
  Null? adminRemarks;
  Null? createdByRole;
  String? timeToMake;
  String? texture;
  String? washCare;
  String? artUsed;
  String? patternUsed;
  String? createdAt;
  String? updatedAt;
  String? buildStatus;
  List<Images>? images;
  Category? category;
  SubCategory? subCategory;
  Artisan? artisan;

  Docs(
      {this.productId,
        this.bhkProductId,
        this.productName,
        this.description,
        this.productPricePerPiece,
        this.quantity,
        this.material,
        this.discount,
        this.netWeight,
        this.dimension,
        this.color,
        this.size,
        this.productStatus,
        this.adminApprovalStatus,
        this.adminRemarks,
        this.createdByRole,
        this.timeToMake,
        this.texture,
        this.washCare,
        this.artUsed,
        this.patternUsed,
        this.createdAt,
        this.updatedAt,
        this.buildStatus,
        this.images,
        this.category,
        this.subCategory,
        this.artisan});

  Docs.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    bhkProductId = json['bhkProductId'];
    productName = json['product_name'];
    description = json['description'];
    productPricePerPiece = json['productPricePerPiece'];
    quantity = json['quantity'];
    material = json['material'];
    discount = json['discount'];
    netWeight = json['netWeight'];
    dimension = json['dimension'];
    if (json['color'] != null) {
      color = List<String>.from(json['color']);
    }
    if (json['size'] != null) {
      size = List<String>.from(json['size']);
    }

    productStatus = json['product_status'];
    adminApprovalStatus = json['admin_approval_status'];
    adminRemarks = json['adminRemarks'];
    createdByRole = json['createdByRole'];
    timeToMake = json['timeToMake'];
    texture = json['texture'];
    washCare = json['washCare'];
    artUsed = json['artUsed'];
    patternUsed = json['patternUsed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    buildStatus = json['build_status'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subCategory = json['subCategory'] != null
        ? new SubCategory.fromJson(json['subCategory'])
        : null;
    artisan =
    json['artisan'] != null ? new Artisan.fromJson(json['artisan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['bhkProductId'] = this.bhkProductId;
    data['product_name'] = this.productName;
    data['description'] = this.description;
    data['productPricePerPiece'] = this.productPricePerPiece;
    data['quantity'] = this.quantity;
    data['material'] = this.material;
    data['discount'] = this.discount;
    data['netWeight'] = this.netWeight;
    data['dimension'] = this.dimension;
    if (this.color != null) {
      data['color'] = this.color!.map((v) => v.toJson()).toList();
    }
    if (this.size != null) {
      data['size'] = this.size!.map((v) => v.toJson()).toList();
    }
    data['product_status'] = this.productStatus;
    data['admin_approval_status'] = this.adminApprovalStatus;
    data['adminRemarks'] = this.adminRemarks;
    data['createdByRole'] = this.createdByRole;
    data['timeToMake'] = this.timeToMake;
    data['texture'] = this.texture;
    data['washCare'] = this.washCare;
    data['artUsed'] = this.artUsed;
    data['patternUsed'] = this.patternUsed;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['build_status'] = this.buildStatus;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.toJson();
    }
    if (this.artisan != null) {
      data['artisan'] = this.artisan!.toJson();
    }
    return data;
  }
}

class Images {
  int? imageId;
  String? imageUrl;
  int? imageOrder;
  String? createdAt;
  String? updatedAt;
  int? productId;

  Images(
      {this.imageId,
        this.imageUrl,
        this.imageOrder,
        this.createdAt,
        this.updatedAt,
        this.productId});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    imageUrl = json['imageUrl'];
    imageOrder = json['imageOrder'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['imageUrl'] = this.imageUrl;
    data['imageOrder'] = this.imageOrder;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['productId'] = this.productId;
    return data;
  }
}

class Category {
  int? categoryId;
  String? categoryName;
  String? type;
  String? categoryLogo;
  String? description;
  Null? parentId;
  String? createdAt;
  String? updatedAt;
  bool? isActive;

  Category(
      {this.categoryId,
        this.categoryName,
        this.type,
        this.categoryLogo,
        this.description,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.isActive});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    type = json['type'];
    categoryLogo = json['category_logo'];
    description = json['description'];
    parentId = json['parent_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['type'] = this.type;
    data['category_logo'] = this.categoryLogo;
    data['description'] = this.description;
    data['parent_id'] = this.parentId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isActive'] = this.isActive;
    return data;
  }
}

class SubCategory {
  int? categoryId;
  String? categoryName;
  String? type;
  String? categoryLogo;
  String? description;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  bool? isActive;

  SubCategory(
      {this.categoryId,
        this.categoryName,
        this.type,
        this.categoryLogo,
        this.description,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.isActive});

  SubCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    type = json['type'];
    categoryLogo = json['category_logo'];
    description = json['description'];
    parentId = json['parent_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['type'] = this.type;
    data['category_logo'] = this.categoryLogo;
    data['description'] = this.description;
    data['parent_id'] = this.parentId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isActive'] = this.isActive;
    return data;
  }
}

class Artisan {
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
  Null? userCasteCategory;
  Null? religion;
  Null? subCaste;
  Null? introVideo;
  Null? aadhaarNumber;
  double? latitude;
  double? longitude;
  Null? loginSource;
  Null? platform;
  Null? guestUserId;

  Artisan(
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
        this.userCasteCategory,
        this.religion,
        this.subCaste,
        this.introVideo,
        this.aadhaarNumber,
        this.latitude,
        this.longitude,
        this.loginSource,
        this.platform,
        this.guestUserId});

  Artisan.fromJson(Map<String, dynamic> json) {
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
    userCasteCategory = json['user_caste_category'];
    religion = json['religion'];
    subCaste = json['subCaste'];
    introVideo = json['introVideo'];
    aadhaarNumber = json['aadhaarNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    data['user_caste_category'] = this.userCasteCategory;
    data['religion'] = this.religion;
    data['subCaste'] = this.subCaste;
    data['introVideo'] = this.introVideo;
    data['aadhaarNumber'] = this.aadhaarNumber;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['loginSource'] = this.loginSource;
    data['platform'] = this.platform;
    data['guestUserId'] = this.guestUserId;
    return data;
  }
}