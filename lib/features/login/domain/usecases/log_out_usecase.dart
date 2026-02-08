import 'package:zartek_flutter_test/features/login/domain/repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository repository;
  const LogOutUseCase(this.repository);

  Future<void> call() => repository.logOut();
}
