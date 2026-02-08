import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel?> signInWithGoogle();
  Future<void> signInWithPhone(String phone);
  Future<UserModel?> verifyOtp(String verificationId, String otp);
  Future<void> logOut();
}
