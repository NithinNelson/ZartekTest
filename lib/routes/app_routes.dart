import 'package:get/get.dart';
import 'package:zartek_flutter_test/features/check_out/presentation/bindings/cart_binding.dart';
import 'package:zartek_flutter_test/features/check_out/presentation/pages/check_out_screen.dart';
import 'package:zartek_flutter_test/features/home/presentation/bindings/home_binding.dart';
import 'package:zartek_flutter_test/features/home/presentation/pages/user_home.dart';
import 'package:zartek_flutter_test/features/login/presentation/pages/login_screen.dart';
import 'package:zartek_flutter_test/features/login/presentation/pages/otp_page.dart';
import 'package:zartek_flutter_test/features/login/presentation/pages/phone_login_page.dart';

class AppRoutes {
  static String splashScreen = '/splash';
  static String login = '/login';
  static String home = '/home';
  static String otp = '/otp';
  static String number = '/number';
  static String checkOut = '/checkOut';

  static final getPages = [
    GetPage(
      name: AppRoutes.login,
      transition: Transition.cupertino,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.number,
      transition: Transition.cupertino,
      page: () => PhoneLoginPage(),
    ),
    GetPage(
      name: AppRoutes.otp,
      transition: Transition.cupertino,
      page: () => OtpPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      transition: Transition.cupertino,
      page: () => UserHome(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: AppRoutes.checkOut,
      transition: Transition.cupertino,
      page: () => CheckoutScreen(),
      binding: CartBinding(),
    ),
  ];

  static Future goNext(String route, {dynamic arguments}) async =>
      Get.toNamed(route, arguments: arguments, preventDuplicates: false);

  static Future<dynamic>? goNextFinishAll(String route, {dynamic arguments}) =>
      Get.offAllNamed(route, arguments: arguments);

  static void goBack({dynamic result}) => Get.back(result: result);

  static void goBackUntil(String screen) =>
      Get.until((route) => Get.currentRoute == screen);
}
