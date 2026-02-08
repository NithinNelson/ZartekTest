import 'package:get/get.dart';
import '../../domain/usecases/get_menu_usecase.dart';
import '../../domain/entities/menu_entity.dart';

class HomeController extends GetxController {
  final GetMenuUseCase getMenuUseCase;

  HomeController(this.getMenuUseCase);

  Rxn<MenuEntity> menu = Rxn<MenuEntity>();
  var loading = false.obs;
  RxInt totalCartItem = 0.obs;

  @override
  void onInit() {
    fetchMenu(loader: true);
    super.onInit();
  }

  final errorMessage = RxnString();
  Future<void> fetchMenu({required bool loader}) async {
    loading.value = loader;
    errorMessage.value = null;
    final result = await getMenuUseCase();
    result.fold((l) => errorMessage.value = l.message, (r) => menu.value = r);
    loading.value = false;
  }

  void increaseQty(int categoryIndex, int dishIndex) {
    final dish = menu.value!.categories[categoryIndex].dishes[dishIndex];
    final updatedDish = dish.copyWith(
      quantity: dish.quantity + 1,
      inCart: true,
    );

    menu.update((m) {
      m!.categories[categoryIndex].dishes[dishIndex] = updatedDish;
    });

    totalCartItem.value =
        menu.value?.categories
            .expand((c) => c.dishes)
            .where((d) => d.inCart)
            .fold<int>(0, (sum, item) => sum + item.quantity) ??
        0;
  }

  void decreaseQty(int categoryIndex, int dishIndex) {
    final dish = menu.value!.categories[categoryIndex].dishes[dishIndex];
    if (dish.quantity == 0) return;

    bool inCart = true;
    if (dish.quantity - 1 == 0) {
      inCart = false;
    }
    final updatedDish = dish.copyWith(
      quantity: dish.quantity - 1,
      inCart: inCart,
    );

    menu.update((m) {
      m!.categories[categoryIndex].dishes[dishIndex] = updatedDish;
    });
    totalCartItem.value =
        menu.value?.categories
            .expand((c) => c.dishes)
            .where((d) => d.inCart)
            .fold<int>(0, (sum, item) => sum + item.quantity) ??
        0;
  }
}
