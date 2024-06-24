import '../../../../core/error/failures.dart';
import '../entities/contact.dart';
import '../repositories/contacts_repository.dart';
import 'package:dartz/dartz.dart';

class CreateContactUseCase {
  final ContactsRepository contactsRepository;

  CreateContactUseCase({required this.contactsRepository});
  Future<Either<Failure, ContactEntity>> call(
      {required ContactEntity contact}) {
    return contactsRepository.createContact(contact: contact);
  }
}
