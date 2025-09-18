class AppUrl {
  //Development
  //static const String baseUrl = 'https://php8.singsys.net/gis/server/public/api';

  //Staging
  static const String baseUrl = 'http://157.20.214.239/product';
  static const String baseUrl2 = 'http://157.20.214.239';
  static const String baseUrl3 = 'http://157.20.214.239/users';

  //Authenication
  static String register = '$baseUrl/api/user/register';
  static String login = '$baseUrl2/auth/api/auth/loginOrRegister';
  static String artisanregistration = '$baseUrl2/auth/api/auth/register_artisan';
  static String availableproductlist = '$baseUrl/api/product/allproductlist';
  static String verifyOtp = '$baseUrl2/auth/api/auth/verify';
  static String logout = '$baseUrl2/auth/api/logout/currentsession';
  static String loggedinuser = '$baseUrl3/api/users/userdetails';
  static String updateprofile = '$baseUrl3/api/users/updateprofile';

  static String categorylist = '$baseUrl/api/category/main-categories?page=1&pageSize=10';

  static String subcategorylist = '$baseUrl/api/category/getsubcategory';
  static String artisanslist = '$baseUrl/api/product/artisan_added_by_employee';
  static String allProductlist = '$baseUrl/api/product/employee/my-products';


  static String addaddress = '$baseUrl3/api/users/addAddress';
  static String addresslist = '$baseUrl3/api/users/addresses_self';
  static String updateAddress = '$baseUrl3/api/users/updateAddress';
  static String deleteAddress = '$baseUrl3/api/users/delete-address';
  static String artisansproductlist = '$baseUrl/api/product/artisan/added_by_employee';
  static String artisansdetails = '$baseUrl3/api/users/artisan';
  static String productdetails = '$baseUrl/api/product/productdetails';


  static String addproduct = '$baseUrl/api/product/addproduct';


  //get
  static String getcategory =
      '$baseUrl/api/category/getallcategory?page=1&pageSize=10';
  static String getsubcategory = '$baseUrl/api/category/getsubcategory/';
  static String getbrand = '$baseUrl/api/brand/getall?page=';
  static String getbranddetails = '$baseUrl/api/brand/getby/';
  static String getstoredetails = '$baseUrl/api/store/getby/';
  static String getstore = '$baseUrl/api/store/getall?page=';
  static String getproductlisting = '$baseUrl/api/product/productlisting';
  static String getproduct = '$baseUrl/api/product/productdetails/';
  static String orders = '$baseUrl/api/order/totalorder';
  static String todayorder = '$baseUrl/api/order/todayorder';
  static String salesgraph = '$baseUrl/api/order/totalsales?year=';
  static String color = '$baseUrl/api/attribute/getattribute';

  //post
  static String addbrand = '$baseUrl/api/brand/add';
  static String addstore = '$baseUrl/api/store/addstore';
  static String addproductmedia = '$baseUrl/api/product/addorupdatemedia';
}
