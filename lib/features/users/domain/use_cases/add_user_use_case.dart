import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class AddUserUseCase {
  UserRepository userRepository;
  AddUserUseCase({
    required this.userRepository,
  });
  Future<Either<Failure, UserEntity>> call({required UserEntity userEntity}) {
    return userRepository.addUser(user: userEntity);
  }
}
