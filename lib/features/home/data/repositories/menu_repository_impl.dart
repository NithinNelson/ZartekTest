import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/menu_entity.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_remote_datasource.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  MenuRepositoryImpl(this.remoteDatasource, this.networkInfo);

  @override
  Future<Either<Failure, MenuEntity>> getMenu() async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDatasource.getMenu();
        return Right(model.toEntity());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure("No internet connection"));
    }
  }
}
