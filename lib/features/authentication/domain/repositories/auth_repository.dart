import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/login.dart';
import '../entities/register.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Unit>> login({required LoginEntity login});
  Future<void> logout();
  Future<Either<Failure, Unit>> register({required RegisterEntity register});
  Future<Either<Failure, Unit>> checkLoggedIn();
}
