import 'dart:typed_data';

import 'package:contact_book/features/contacts/domain/entities/send_email_entity.dart';

import '../../../../core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../entities/contact_entity.dart';

abstract interface class ContactsRepository {
  Future<Either<Failure, List<ContactEntity>>> getAllContacts();

  Future<Either<Failure, ContactEntity>> createContact(
      {required ContactEntity contact});

  Future<Either<Failure, Unit>> deleteContacts(
      {required List<ContactEntity> contacts});

  Future<Either<Failure, ContactEntity>> getContact({required int id});

  Future<Either<Failure, ContactEntity>> updateContact(
      {required ContactEntity contact});

  Future<Either<Failure, Unit>> deleteContact({required int id});

  Future<Either<Failure, ContactEntity>> toggleFavorite(
      {required ContactEntity contact});

  Future<Either<Failure, Unit>> sendEmail(
      {required SendEmailEntity sendEmailEntity});

  Future<Either<Failure, Uint8List>> getContactImage(ContactEntity contact);
}
