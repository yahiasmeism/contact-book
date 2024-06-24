import '../../../../core/error/failures.dart';
import '../repositories/contacts_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteContactUseCase {
  final ContactsRepository contactsRepository;

  DeleteContactUseCase({required this.contactsRepository});
  Future<Either<Failure, Unit>> call({required int id}) {
    return contactsRepository.deleteContact(id: id);
  }
}
