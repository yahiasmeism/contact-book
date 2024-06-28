import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:contact_book/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class GetContactImageUseCase {
  final ContactsRepository contactsRepository;

  GetContactImageUseCase({required this.contactsRepository});

  Future<Either<Failure, Uint8List>> call({required ContactEntity contact}) {
    return contactsRepository.getContactImage(contact);
  }
}
