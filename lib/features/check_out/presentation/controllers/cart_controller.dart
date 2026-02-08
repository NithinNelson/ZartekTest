import 'package:get/get.dart';
import 'package:zartek_flutter_test/features/home/domain/entities/dish_entity.dart';
import 'package:zartek_flutter_test/features/home/presentation/controllers/home_controller.dart';

class CartController extends GetxController {
  RxList<DishEntity> dishes = <DishEntity>[].obs;
  RxDouble dishTotal = 0.0.obs;
  final HomeController _homeController = Get.find<HomeController>();

  @override
  void onInit() {
    dishes.value =
        _homeController.menu.value?.categories
            .expand(
              (element) => element.dishes
                  .where((v) => v.inCart)
                  .map(
                    (a) => a.copyWith(
                      categoryId: element.id,
                      cartTotal: a.quantity * a.price,
                      totalCalories: a.quantity * a.calories,
                    ),
                  ),
            )
            .toList() ??
        [];
    dishTotal.value = dishes.fold<double>(
      0,
      (sum, item) => sum + item.cartTotal,
    );
    super.onInit();
  }

  void increaseQty(int dishIndex) {
    final dish = dishes[dishIndex];
    final updatedDish = dish.copyWith(
      quantity: dish.quantity + 1,
      inCart: true,
      cartTotal: (dish.quantity + 1) * dish.price,
      totalCalories: (dish.quantity + 1) * dish.calories,
    );

    dishes[dishIndex] = updatedDish;
    dishTotal.value = dishes.fold<double>(
      0,
      (sum, item) => sum + item.cartTotal,
    );
    int categoryIndex =
        _homeController.menu.value?.categories.indexWhere(
          (element) => element.id == dish.categoryId,
        ) ??
        -1;
    if (categoryIndex == -1) return;
    int homeDishIndex =
        _homeController.menu.value?.categories[categoryIndex].dishes.indexWhere(
          (element) => element.id == dish.id,
        ) ??
        -1;
    if (homeDishIndex == -1) return;
    _homeController.increaseQty(categoryIndex, homeDishIndex);
  }

  void decreaseQty(int dishIndex) {
    final dish = dishes[dishIndex];
    if (dish.quantity == 0) return;

    bool inCart = true;
    if (dish.quantity - 1 == 0) {
      inCart = false;
    }
    final updatedDish = dish.copyWith(
      quantity: dish.quantity - 1,
      inCart: inCart,
      cartTotal: (dish.quantity - 1) * dish.price,
      totalCalories: (dish.quantity - 1) * dish.calories,
    );

    dishes[dishIndex] = updatedDish;
    dishTotal.value = dishes.fold<double>(
      0,
      (sum, item) => sum + item.cartTotal,
    );
    int categoryIndex =
        _homeController.menu.value?.categories.indexWhere(
          (element) => element.id == dish.categoryId,
        ) ??
        -1;
    if (categoryIndex == -1) return;
    int homeDishIndex =
        _homeController.menu.value?.categories[categoryIndex].dishes.indexWhere(
          (element) => element.id == dish.id,
        ) ??
        -1;
    if (homeDishIndex == -1) return;
    _homeController.decreaseQty(categoryIndex, homeDishIndex);
    if (dish.quantity - 1 == 0) {
      dishes.removeAt(dishIndex);
    }
  }
}
