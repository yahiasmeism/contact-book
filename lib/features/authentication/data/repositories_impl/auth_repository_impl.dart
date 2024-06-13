import 'package:contact_book/core/constants/messages.dart';
import 'package:contact_book/core/error/exceptions.dart';

import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/login.dart';
import '../../domain/entities/register.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthLocalDataSource local;
  AuthRemoteDataSource remote;
  AuthRepositoryImpl({
    required this.local,
    required this.remote,
  });
  @override
  Future<Either<Failure, Unit>> login({required LoginEntity login}) async {
    try {
      // should be returned auth token if no Exception
      String token = await remote.login(LoginModel.fromEntity(login));

      await local.storeToken(token);

      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> register(
      {required RegisterEntity register}) async {
    try {
      await remote.register(RegisterModel.fromEntity(register));
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<void> logout() async {
    await local.removeToken();
    await local.clearAppData();
  }

  @override
  Future<Either<Failure, Unit>> checkLoggedIn() {
    if (local.getToken() != null) {
      return Future.value(const Right(unit));
    } else {
      return Future.value(
        Left(NetworkFailure(message: MESSAGES.NOT_LOGGED_IN)),
      );
    }
  }
}
