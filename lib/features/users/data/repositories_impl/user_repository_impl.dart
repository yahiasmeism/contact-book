import 'package:contact_book/core/error/exceptions.dart';
import 'package:contact_book/features/users/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/core/network/network_info.dart';
import 'package:contact_book/features/users/data/data_sources/users_local_data_source.dart';
import 'package:contact_book/features/users/data/data_sources/users_remote_data_source.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/domain/repositories/user_repository.dart';

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
    return _getData<List<UserEntity>>(
      getLoacal: usersLocal.getAllUsers,
      getRemote: () async {
        List<UserModel> usersModel = await usersRemote.getAllUsers();
        usersLocal.storeUsers(users: usersModel);

        return usersModel.map((u) => u.toEntity()).toList();
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    return _getData<UserEntity>(
      getLoacal: usersLocal.getCurrentUser,
      getRemote: usersRemote.getCurrentUser,
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteUsers(
      {required List<String> usersId}) async {
    try {
      await usersRemote.deleteUsers(usersId: usersId);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(
      {required UserEntity userEntity}) async {
    try {
      final updatedUser = await usersRemote.updateUser(
          userModel: UserModel.fromEntity(userEntity));
      return Right(updatedUser.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> addUser(
      {required UserEntity user}) async {
    try {
      UserModel userModel = UserModel.fromEntity(user);
      UserEntity userEntity = await usersRemote.addUser(userModel: userModel);
      return Right(userEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  /// getting data from remote or local task based on network connectivity.
  /// If the device is connected to the network, it executes the [getRemote], otherwise, it executes the [localTask].
  /// Returns an [Either] object representing the success or failure of the operation.
  Future<Either<Failure, T>> _getData<T>({
    required Future<T> Function() getRemote,
    required Future<T> Function() getLoacal,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        return Right(await getRemote());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        return Right(await getLoacal());
      } on DatabaseException catch (e) {
        return Left(DatabaseFailure(message: e.message));
      }
    }
  }
}
