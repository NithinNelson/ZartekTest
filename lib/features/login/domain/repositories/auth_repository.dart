import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signInWithGoogle();
  Future<void> signInWithPhone(String phone);
  Future<UserEntity?> verifyOtp(String verificationId, String otp);
  Future<void> logOut();
}
