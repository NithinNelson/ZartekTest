import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zartek_flutter_test/features/home/presentation/controllers/home_controller.dart';
import '../services/snackbar_service.dart';

class NetworkController extends GetxController {
  final Connectivity connectivity;

  NetworkController(this.connectivity);

  var isOffline = false.obs;

  @override
  void onInit() {
    super.onInit();

    connectivity.onConnectivityChanged.listen((result) {
      final offline = result.contains(ConnectivityResult.none);

      if (offline != isOffline.value) {
        isOffline.value = offline;
        if(offline) {
          SnackBarService.showNetworkStatus(offline);
        } else {
          Get.closeCurrentSnackbar();
          User? user = FirebaseAuth.instance.currentUser;
          if(user != null) {
            if(Get.isRegistered<HomeController>()) {
              Get.find<HomeController>().fetchMenu(loader: true);
            }
          }
        }
      }
    });
  }
}
