// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/domain/repositories/user_repository.dart';

class GetCurrentUserUseCase {
  UserRepository userRepository;
  GetCurrentUserUseCase({
    required this.userRepository,
  });
  Future<Either<Failure, UserEntity>> call() {
    return userRepository.getCurrentUser();
  }
}
