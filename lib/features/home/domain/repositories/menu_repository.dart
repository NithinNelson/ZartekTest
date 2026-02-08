import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/menu_entity.dart';

abstract class MenuRepository {
  Future<Either<Failure, MenuEntity>> getMenu();
}
