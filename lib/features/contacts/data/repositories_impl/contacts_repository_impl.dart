import 'package:contact_book/core/constants/assets.dart';
import 'package:contact_book/features/contacts/data/models/contact_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helpers/excute_remote_or_local.dart';
import '../data_sources/contact_local_data_source.dart';
import '../../domain/entities/contact_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/contacts_repository.dart';
import '../data_sources/contact_remote_data_source.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final NetworkInfo networkInfo;
  final ContactLocalDataSourceImpl contactLocal;
  final ContactRemoteDataSourceImpl contactRemote;

  ContactsRepositoryImpl({
    required this.contactLocal,
    required this.contactRemote,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ContactEntity>> createContact(
      {required ContactEntity contact}) async {
    ContactModel contactModel = ContactModel.fromEntity(contact);
    try {
      contactModel =
          await contactRemote.createContact(contactModel: contactModel);
      await contactLocal.storeContact(contact: contactModel);
      return right(contactModel);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteContact({required int id}) async {
    try {
      await contactRemote.deleteContact(id: id);
      await contactLocal.deleteContact(id: id);
      return right(unit);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<ContactEntity>>> getAllContacts() async {
    return executeRemoteOrLocal(
      networkInfo: networkInfo,
      remoteCall: () => contactRemote.getAllContacts(),
      localCall: () => contactLocal.getAllContacts(),
    );
  }

  @override
  Future<Either<Failure, ContactEntity>> getContact({required int id}) async {
    return executeRemoteOrLocal(
      networkInfo: networkInfo,
      remoteCall: () => contactRemote.getContact(id: id),
      localCall: () => contactLocal.getContact(id: id),
    );
  }

  @override
  Future<Either<Failure, ContactEntity>> toggleFavorite(
      {required ContactEntity contact}) async {
    ContactModel contactModel = ContactModel.fromEntity(contact);
    try {
      contactModel = await contactRemote.toggleFavorite(contact: contactModel);
      await contactLocal.storeContact(contact: contactModel);
      return right(contactModel.toEntity());
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ContactEntity>> updateContact(
      {required ContactEntity contact}) async {
    ContactModel contactModel = ContactModel.fromEntity(contact);
    try {
      contactModel = await contactRemote.updateContact(contact: contactModel);
      await contactLocal.storeContact(contact: contactModel);
      return right(contactModel.toEntity());
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteContacts(
      {required List<ContactEntity> contacts}) async {
    try {
      await contactRemote.deleteContacts(contacts: contacts);
      return right(unit);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getImageUrl({required int id}) async {
    return executeRemoteOrLocal(
      networkInfo: networkInfo,
      remoteCall: () async => await contactRemote.getImageUrl(id: id),
      localCall: () async {
        final contact = await contactLocal.getContact(id: id);
        return contact.imageUrl ?? ASSETS.PLACEHOLDER;
      },
    );
  }
}
