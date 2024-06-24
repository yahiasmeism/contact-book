import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

import '../entities/contact_entity.dart';
import '../repositories/contacts_repository.dart';

class GetContactUseCase {
  final ContactsRepository contactsRepository;

  GetContactUseCase({required this.contactsRepository});
  Future<Either<Failure, ContactEntity>> call({required int id}) {
    return contactsRepository.getContact(id: id);
  }
}
