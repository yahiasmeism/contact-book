import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class DeleteUsersUseCase {
  UserRepository userRepository;
  DeleteUsersUseCase({
    required this.userRepository,
  });
  Future<Either<Failure, Unit>> call({required List<UserEntity> users}) {
    return userRepository.deleteUsers(users: users);
  }
}
