import 'package:dartz/dartz.dart';

import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/features/users/domain/repositories/user_repository.dart';

class DeleteUserByIdUseCase {
  UserRepository userRepository;
  DeleteUserByIdUseCase({
    required this.userRepository,
  });
  Future<Either<Failure, Unit>> call({required String id}) {
    return userRepository.deleteUser(id: id);
  }
}
