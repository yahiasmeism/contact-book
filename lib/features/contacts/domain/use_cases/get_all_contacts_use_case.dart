
import '../entities/contact_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/contacts_repository.dart';

class GetAllContactsUseCase {
  final ContactsRepository contactsRepository;

  GetAllContactsUseCase({required this.contactsRepository});
  Future<Either<Failure, List<ContactEntity>>> call() {
    return contactsRepository.getAllContacts();
  }
}
