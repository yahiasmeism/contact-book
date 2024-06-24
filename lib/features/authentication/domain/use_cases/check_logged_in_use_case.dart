import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class CheckIsLoggedInUseCase {
  AuthRepository authRepository;
  CheckIsLoggedInUseCase({
    required this.authRepository,
  });
  Future<Either<Failure, Unit>> call() {
    return authRepository.checkLoggedIn();
  }
}
