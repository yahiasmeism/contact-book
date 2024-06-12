import 'package:contact_book/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class DeleteUsersUseCase {
  UserRepository userRepository;
  DeleteUsersUseCase({
    required this.userRepository,
  });
  Future<Either<Failure, Unit>> call({required List<String> usersId}) {
    return userRepository.deleteUsers(usersId: usersId);
  }
}
