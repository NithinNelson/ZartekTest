import 'package:get/get.dart';
import 'package:zartek_flutter_test/features/login/presentation/controllers/login_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(), permanent: true);
  }
}
