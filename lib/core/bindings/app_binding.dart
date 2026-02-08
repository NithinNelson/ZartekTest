import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:zartek_flutter_test/features/login/presentation/controllers/login_controller.dart';

import '../network/connectivity_service.dart';
import '../network/network_controller.dart';
import '../network/network_info.dart';
import '../network/network_info_impl.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Connectivity());
    Get.put(ConnectivityService(Get.find()));
    Get.put<NetworkInfo>(NetworkInfoImpl(Get.find()));
    Get.put(NetworkController(Get.find()), permanent: true);
    Get.put(LoginController(), permanent: true);
  }
}
