import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zartek_flutter_test/features/home/presentation/controllers/home_controller.dart';
import '../../data/datasources/menu_remote_datasource.dart';
import '../../data/repositories/menu_repository_impl.dart';
import '../../domain/repositories/menu_repository.dart';
import '../../domain/usecases/get_menu_usecase.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(http.Client());
    Get.put<MenuRemoteDatasource>(MenuRemoteDatasourceImpl(Get.find()));

    Get.put<MenuRepository>(MenuRepositoryImpl(Get.find(), Get.find()));

    Get.put(GetMenuUseCase(Get.find()));

    Get.put(HomeController(Get.find()));
  }
}
