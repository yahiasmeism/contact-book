import 'package:contact_book/features/contacts/data/models/contact_model.dart';
import 'package:contact_book/features/contacts/data/models/send_email_model.dart';
import 'package:contact_book/features/contacts/domain/entities/send_email_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helpers/excute_remote_or_local.dart';
import '../../domain/entities/contact_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/contacts_repository.dart';
import '../data_sources/contacts_local_data_source.dart';
import '../data_sources/contacts_remote_data_source.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final NetworkInfo networkInfo;
  final ContactsLocalDataSource local;
  final ContactsRemoteDataSource remote;

  ContactsRepositoryImpl({
    required this.local,
    required this.remote,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ContactEntity>> createContact(
      {required ContactEntity contact}) async {
    ContactModel contactModel = ContactModel.fromEntity(contact);
    try {
      contactModel = await remote.createContact(contactModel: contactModel);
      await local.storeContact(contact: contactModel);
      return right(contactModel);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteContact({required int id}) async {
    try {
      await remote.deleteContact(id: id);
      await local.deleteContact(id: id);
      return right(unit);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<ContactEntity>>> getAllContacts() async {
    return executeRemoteOrLocal(
      networkInfo: networkInfo,
      remoteCall: () async {
        final contacts = await remote.getAllContacts();
        await local.storeListOfContacts(contacts: contacts);
        return contacts.map((contact) => contact.toEntity()).toList();
      },
      localCall: () => local.getAllContacts(),
    );
  }

  @override
  Future<Either<Failure, ContactEntity>> getContact({required int id}) async {
    return executeRemoteOrLocal(
      networkInfo: networkInfo,
      remoteCall: () async {
        final contact = await remote.getContact(id: id);
        await local.storeContact(contact: contact);
        return contact;
      },
      localCall: () => local.getContact(id: id),
    );
  }

  @override
  Future<Either<Failure, ContactEntity>> toggleFavorite(
      {required ContactEntity contact}) async {
    var contactModel = ContactModel.fromEntity(contact);
    try {
      contactModel = await remote.toggleFavorite(contact: contactModel);
      await local.storeContact(contact: contactModel.toEntity());
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
    return right(contactModel.toEntity());
  }

  @override
  Future<Either<Failure, ContactEntity>> updateContact(
      {required ContactEntity contact}) async {
    ContactModel contactModel = ContactModel.fromEntity(contact);
    try {
      contactModel = await remote.updateContact(contact: contactModel);
      await local.storeContact(contact: contactModel);
      return right(contactModel.toEntity());
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteContacts(
      {required List<ContactEntity> contacts}) async {
    try {
      await remote.deleteContacts(contacts: contacts);
      await local.deleteContacts(contacts: contacts);
      return right(unit);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendEmail(
      {required SendEmailEntity sendEmailEntity}) async {
    try {
      await remote.sendEmail(
          sendEmail: SendEmailModel.fromEntity(sendEmailEntity));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
    return right(unit);
  }
}
