import '../repositories/auth_repository.dart';

class PhoneSignInUseCase {
  final AuthRepository repository;

  PhoneSignInUseCase(this.repository);

  Future<void> call(String phone) => repository.signInWithPhone(phone);
}
