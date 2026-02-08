import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasourceImpl datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserEntity?> signInWithGoogle() => datasource.signInWithGoogle();

  @override
  Future<void> signInWithPhone(String phone) => datasource.signInWithPhone(phone);

  @override
  Future<UserEntity?> verifyOtp(String verificationId, String otp) =>
      datasource.verifyOtp(verificationId, otp);

  @override
  Future<void> logOut() => datasource.logOut();
}
