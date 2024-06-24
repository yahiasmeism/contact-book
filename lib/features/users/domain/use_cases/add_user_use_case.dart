import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';
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
