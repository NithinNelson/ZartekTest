import 'package:dartz/dartz.dart';
import 'package:zartek_flutter_test/core/network/network_info.dart';
import 'package:zartek_flutter_test/features/login/data/models/user_model.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasourceImpl datasource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.datasource, {required this.networkInfo});

  @override
  Future<Either<Failure, UserEntity?>> signInWithGoogle() async {
    if (await networkInfo.isConnected) {
      try {
        UserModel? user = await datasource.signInWithGoogle();
        return Right(user);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure("No internet connection"));
    }
  }

  @override
  Future<void> signInWithPhone(String phone) => datasource.signInWithPhone(phone);

  @override
  Future<UserEntity?> verifyOtp(String verificationId, String otp) =>
      datasource.verifyOtp(verificationId, otp);

  @override
  Future<void> logOut() => datasource.logOut();
}
