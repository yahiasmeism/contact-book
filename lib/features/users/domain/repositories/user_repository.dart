import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
  Future<Either<Failure, UserEntity>> addUser(
      {required UserEntity user});
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, UserEntity>> updateUser(
      {required UserEntity userEntity});
  Future<Either<Failure, Unit>> deleteUsers({required List<String> usersId});
}
