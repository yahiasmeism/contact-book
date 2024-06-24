
import '../entities/contact_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/contacts_repository.dart';

class UpdateContactUseCase {
  final ContactsRepository contactsRepository;

  UpdateContactUseCase({required this.contactsRepository});
  Future<Either<Failure, ContactEntity>> call(
      {required ContactEntity contact}) {
    return contactsRepository.updateContact(contact: contact);
  }
}
