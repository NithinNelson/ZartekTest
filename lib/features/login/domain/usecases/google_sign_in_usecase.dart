import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class GoogleSignInUseCase {
  final AuthRepository repository;

  GoogleSignInUseCase(this.repository);

  Future<UserEntity?> call() => repository.signInWithGoogle();
}
