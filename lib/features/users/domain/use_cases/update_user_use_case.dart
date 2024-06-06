import 'package:dartz/dartz.dart';

import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/domain/repositories/user_repository.dart';

class UpdateUserUseCase {
 UserRepository userRepository;
  UpdateUserUseCase({
    required this.userRepository,
  });
  Future<Either<Failure, UserEntity>> call({required UserEntity userEntity}) {
    return userRepository.updateUser(userEntity);
  } 
}
