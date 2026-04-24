class AppImages {
  static get logo => 'assets/images/logo.png';
  static get supportbg => 'assets/images/supportimage.jpg';

  static get product1 => 'assets/images/Product1.png';
  static get product2 => 'assets/images/Product2.png';
  static get product3 => 'assets/images/Product3.png';
  static get product4 => 'assets/images/Product4.png';
  static get product5 => 'assets/images/Product5.png';
  static get product6 => 'assets/images/Product6.png';
  static get product7 => 'assets/images/Product7.png';
  static get product8 => 'assets/images/Product8.png';
  static get googleIcon => 'assets/images/google_icon.png';
  static get bhkbackground => 'assets/images/BHKbacground.jpg';
  static get profile => 'assets/images/Profile.png';
  static get myproductcart => 'assets/images/myproductcart.png';
  static get orderscreen => 'assets/images/orderscreen.gif';
  static get firstbrand => 'assets/images/firstbrand.png';
  static get storeimage => 'assets/images/storeimage.png';
  static get firststock => 'assets/images/firststock.png';
  static get loaderouter => 'assets/images/splashscreenouter.png';
  static get support => "assets/images/support.png";
  static get artisanIcon => "assets/images/icon1.png";

  static final AppImages _appImages = AppImages._internal();
  factory AppImages() {
    return _appImages;
  }
  AppImages._internal();
}

AppImages appImages = AppImages();
