import '../../domain/entities/menu_entity.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_remote_datasource.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDatasource remoteDatasource;

  MenuRepositoryImpl(this.remoteDatasource);

  @override
  Future<MenuEntity> getMenu() async {
    final model = await remoteDatasource.getMenu();
    return model.toEntity();
  }
}
