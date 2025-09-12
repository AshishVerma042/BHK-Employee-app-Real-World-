
import 'package:bhk_employee/Modules/screens/artisanManagement/artisan_search_screen.dart';
import 'package:get/get.dart';
import '../Modules/screens/artisanManagement/add_product_screen.dart';
import '../Modules/screens/artisanManagement/artisan_profile_screen.dart';
import '../Modules/screens/artisanManagement/artisans.dart';
import '../Modules/screens/artisanManagement/product_detail_page.dart';
import '../Modules/screens/artisanManagement/registration_screen.dart';
import '../Modules/screens/profileManagement/address_screen.dart';
import '../Modules/screens/profileManagement/edit_profile_screen.dart';
import '../Modules/screens/profileManagement/settingprofile.dart';
import '../Modules/screens/profileManagement/support.dart';
import '../Modules/screens/login_screen.dart';
import '../Modules/screens/otp_screen.dart';
import '../Modules/screens/profileManagement/view_profile.dart';
import '../Modules/screens/splash_screen.dart';
import '../Modules/screens/common_screen.dart';


class RoutesClass {
  //BR1
  static String splash = '/splash';
  static String dashboard = '/dashboard';
  static String newScreen = '/newScreen';
  static String commonScreen = '/commonScreen';

  static String login = '/login';
  static String verify = '/verify';

  static String products = '/products';
  static String addproducts = '/addproducts';
  static String addproductdetails = '/addproductdetails';
  static String addproductmedia = '/addproductmedia';
  static String orders = '/orders';
  static String ordersdetails = '/ordersdetails';
  static String ordertracking = '/ordertracking';
  static String profile = '/profile';
  static String notifications = '/notifications';
  static String changepassword = '/changepassword';
  static String setting = '/setting';
  static String editprofile = '/editprofile';
  static String viewprofile = '/viewprofile';
  static String productdetail = '/productdetail';

  static String termscondition = '/termscondition';
  static String privacypolicy = '/privacypolicy';
  static String artisans = '/artisans';
  static String faq = '/faq';
  static String support = '/support';
  static String registration = '/registration';
  static String addProductScreen = '/addProductScreen';
  static String productDetailsScreen = "/productDetail";
  static String artisanSearchScreen = "/artisanSearchScreen";
  static String artisanProfile = '/artisanProfile';
  static String address = '/address';

  //BR1
  static String gotoArtisanSearchScreen() => artisanSearchScreen;
  static String gotoArtisanProfileScreen() => artisanProfile;
  static String gotoProductDetailsScreen() => productDetailsScreen;
  static String gotoAddressScreen() => address;
  static String gotoSplash() => splash;
  static String gotoDashboardScreen() => dashboard;
  static String gotoLoginScreen() => login;
  static String gotoNewScreen() => newScreen;
  static String gotoArtisans()=> artisans;
  static String gotoSupport() => support;
  static String gotoRegistration() => registration;
  static String gotoCommonScreen()=>commonScreen;
  static String gotoAddProductPage() => addProductScreen;

  static String gotoVerifyScreen() => verify;

  static String gotoProductScreen() => products;
  static String gotoaddProductScreen() => addproducts;
  static String gotoaddProductdetailsScreen() => addproductdetails;
  static String gotoaddProductmediaScreen() => addproductmedia;
  static String gotoOrderScreen() => orders;
  static String gotoOrderDetailsScreen() => ordersdetails;
  static String gotoOrderTrackingScreen() => ordertracking;
  static String gotoProfileScreen() => profile;
  static String gotoNotificationScreen() => notifications;
  static String gotoChangePasswordScreen() => changepassword;
  static String gotoSettingScreen() => setting;
  static String gotoEditProfileScreen() => editprofile;
  static String gotoViewProfileScreen() => viewprofile;
  static String gotoProductDetailScreen() => productdetail;
  static String gotoTermsConditionScreen() => termscondition;
  static String gotoPrivacyPolicyScreen() => privacypolicy;
  static String gotoFAQScreen() => faq;
  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: editprofile,
      page: () => EditProfile(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: address,
      page: () => AddressScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: setting,
      page: () => SettingProfile(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ), GetPage(
      name: artisanSearchScreen,
      page: () => ArtisanSearchScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: support,
      page: () => Support(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: registration,
      page: () => Registration(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: addProductScreen,
      page: () => AddProductPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: artisanProfile,
      page: () => ArtisanProfileScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: productDetailsScreen,
      page: () => ProductDetailScreen(product: Get.arguments),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),


    GetPage(
        name: login,
        page: () =>LoginScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
      //binding: LoginBinding(),
    ),
    GetPage(
      name: verify,
      page: () => OtpScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: viewprofile,
      page: () => ViewProfile(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: commonScreen,
      page: () => CommonScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: artisans,
      page: () =>  Artisans(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

  ];
}