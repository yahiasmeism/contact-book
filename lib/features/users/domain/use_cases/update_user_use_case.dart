import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class UpdateUserUseCase {
  UserRepository userRepository;
  UpdateUserUseCase({
    required this.userRepository,
  });
  Future<Either<Failure, UserEntity>> call({required UserEntity userEntity}) {
    return userRepository.updateUser(userEntity: userEntity);
  }
}
