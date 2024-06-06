import '../repositories/auth_repository.dart';

class LogoutUseCase {
  AuthRepository authRepository;
  LogoutUseCase({
    required this.authRepository,
  });

  Future<void> call() async {
    return authRepository.logout();
  }
}
