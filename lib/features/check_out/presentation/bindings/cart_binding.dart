
import 'package:get/get.dart';
import 'package:zartek_flutter_test/features/check_out/presentation/controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}