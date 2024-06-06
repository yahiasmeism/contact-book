import '../../../../core/error/failures.dart';
import '../entities/register.dart';
import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase {
  AuthRepository authRepository;
  RegisterUseCase({
    required this.authRepository,
  });

  Future<Either<Failure, Unit>> call({required RegisterEntity register}) {
    return authRepository.register(register: register);
  }
}
