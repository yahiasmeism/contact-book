import '../repositories/contacts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/contact.dart';

class DeleteContactsUseCase {
  final ContactsRepository contactsRepository;

  DeleteContactsUseCase({required this.contactsRepository});
  Future<Either<Failure, Unit>> call({required List<ContactEntity> contacts}) {
    return contactsRepository.deleteContacts(contacts: contacts);
  }
}
