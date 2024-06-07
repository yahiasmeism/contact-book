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
  Future<Either<Failure, Unit>> deleteUserById(String id) async {
    return await _performDataOperation<Unit>(remoteTask: () async {
      usersRemote.deleteUserById(id);
      return unit;
    }, loacalTask: () async {
      usersLocal.deleteUserById(id);
      return unit;
    });
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    return _performDataOperation<List<UserEntity>>(
      loacalTask: usersLocal.getAllUsers,
      remoteTask: usersRemote.getAllUsers,
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    return _performDataOperation<UserEntity>(
      loacalTask: usersLocal.getCurrentUser,
      remoteTask: usersRemote.getCurrentUser,
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(String id) {
    return _performDataOperation<UserEntity>(
      loacalTask: () => usersLocal.getUserById(id),
      remoteTask: () => usersRemote.getUserById(id),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(UserEntity userEntity) {
    return _performDataOperation(
      remoteTask: () =>
          usersRemote.updateUser(UserModel.fromEntity(userEntity)),
      loacalTask: () => usersLocal.updateUser(UserModel.fromEntity(userEntity)),
    );
  }

  /// Performs a data operation by executing a remote or local task based on network connectivity.
  /// If the device is connected to the network, it executes the [remoteTask], otherwise, it executes the [localTask].
  /// Returns an [Either] object representing the success or failure of the operation.
  Future<Either<Failure, T>> _performDataOperation<T>({
    required Future<T> Function() remoteTask,
    required Future<T> Function() loacalTask,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        return Right(await remoteTask());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        return Right(await loacalTask());
      } on DatabaseException catch (e) {
        return Left(EmptyChacheFailure(message: e.message));
      }
    }
  }
}
