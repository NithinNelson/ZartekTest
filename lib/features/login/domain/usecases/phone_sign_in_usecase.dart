import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class PhoneSignInUseCase {
  final AuthRepository repository;

  PhoneSignInUseCase(this.repository);

  Future<Failure?> call(String phone) => repository.signInWithPhone(phone);
}
