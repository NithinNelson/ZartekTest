import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zartek_flutter_test/core/error/firebase_error_mapper.dart';
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
  Future<Failure?> signInWithPhone(String phone) async {
    if (await networkInfo.isConnected) {
      try {
        await datasource.signInWithPhone(phone);
      } on FirebaseAuthException catch(e) {
        return ServerFailure(FirebaseErrorMapper.map(e.message ?? e.code));
      } catch(e) {
        return ServerFailure(e.toString());
      }
    } else {
      NetworkFailure("No internet connection");
    }
    return null;
  }

  @override
  Future<UserEntity?> verifyOtp(String verificationId, String otp) =>
      datasource.verifyOtp(verificationId, otp);

  @override
  Future<void> logOut() => datasource.logOut();
}
