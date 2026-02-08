import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/menu_entity.dart';
import '../repositories/menu_repository.dart';

class GetMenuUseCase {
  final MenuRepository repository;

  GetMenuUseCase(this.repository);

  Future<Either<Failure, MenuEntity>> call() async {
    return await repository.getMenu();
  }
}
