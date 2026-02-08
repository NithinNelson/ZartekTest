import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<UserEntity?> call(String verificationId, String otp) =>
      repository.verifyOtp(verificationId, otp);
}
