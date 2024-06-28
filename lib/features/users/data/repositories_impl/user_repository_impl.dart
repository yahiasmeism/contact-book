import 'package:contact_book/core/helpers/excute_remote_or_local.dart';

import '../../../../core/constants/constant.dart';
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
    return executeRemoteOrLocal<List<UserEntity>>(
      networkInfo: networkInfo,
      localCall: usersLocal.getAllUsers,
      remoteCall: () async {
        List<UserModel> usersModel = await usersRemote.getAllUsers();
        await usersLocal.storeAllUsers(users: usersModel);

        return usersModel.map((u) => u.toEntity()).toList();
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    return executeRemoteOrLocal<UserEntity>(
      networkInfo: networkInfo,
      remoteCall: () async {
        final user = await usersRemote.getCurrentUser();
        await usersLocal.storeUser(id: CURRENT_USER_KEY, user: user);
        return user;
      },
      localCall: usersLocal.getCurrentUser,
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

      usersLocal.storeUser(id: userEntity.id!, user: updatedUser);
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
      await usersLocal.storeUser(id: userEntity.id!, user: userEntity);
      return Right(userEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    }
  }
}
