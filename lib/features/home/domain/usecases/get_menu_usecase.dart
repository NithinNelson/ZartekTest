import '../entities/menu_entity.dart';
import '../repositories/menu_repository.dart';

class GetMenuUseCase {
  final MenuRepository repository;

  GetMenuUseCase(this.repository);

  Future<MenuEntity> call() async {
    return await repository.getMenu();
  }
}
