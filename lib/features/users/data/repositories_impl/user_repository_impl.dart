import 'package:contact_book/core/helpers/excute_remote_or_local.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/users_local_data_source.dart';
import '../data_sources/users_remote_data_source.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  NetworkInfo networkInfo;
  UsersLocalDataSource usersLocal;
  UsersRemoteDataSource usersRemote;
  UserRepositoryImpl({
    required this.networkInfo,
    required this.usersLocal,
    required this.usersRemote,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    return await executeRemoteOrLocal<List<UserEntity>>(
      remoteCall: () async {
        final users = await usersRemote.getAllUsers();
        await usersLocal.storeAllUsers(users: users);
        return users.map((e) => e.toEntity()).toList();
      },
      localCall: usersLocal.getAllUsers,
      networkInfo: networkInfo,
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    return await executeRemoteOrLocal<UserEntity>(
      networkInfo: networkInfo,
      remoteCall: () async {
        final user = await usersRemote.getCurrentUser();
        await usersLocal.storeCurrentUser(user: user);
        return user;
      },
      localCall: () async => await usersLocal.getCurrentUser(),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteUsers(
      {required List<UserEntity> users}) async {
    try {
      await usersRemote.deleteUsers(users: users);
      await usersLocal.deleteUsers(users: users);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(
      {required UserEntity userEntity}) async {
    try {
      final updatedUser = await usersRemote.updateUser(
          userModel: UserModel.fromEntity(userEntity));
      await usersLocal.storeUser(user: userEntity);
      return Right(updatedUser.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> addUser(
      {required UserEntity user}) async {
    try {
      UserModel userModel = UserModel.fromEntity(user);
      UserEntity userEntity = await usersRemote.addUser(userModel: userModel);
      await usersLocal.storeUser(user: userEntity);
      return Right(userEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    }
  }
}
