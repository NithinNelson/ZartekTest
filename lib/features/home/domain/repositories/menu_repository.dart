import '../entities/menu_entity.dart';

abstract class MenuRepository {
  Future<MenuEntity> getMenu();
}
