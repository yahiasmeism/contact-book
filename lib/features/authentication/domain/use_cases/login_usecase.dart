// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/login.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  AuthRepository authRepository;
  LoginUseCase({
    required this.authRepository,
  });

  Future<Either<Failure, Unit>> call({required LoginEntity login}) {
    return authRepository.login(login: login);
  }
}
