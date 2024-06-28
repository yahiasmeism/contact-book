import 'package:contact_book/core/error/exceptions.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/contact_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constants/constant.dart';

abstract interface class ContactsLocalDataSource {
  Future<void> storeListOfContacts({required List<ContactEntity> contacts});
  Future<ContactEntity> getContact({required int id});
  Future<void> deleteContacts({required List<ContactEntity> contacts});
  Future<void> deleteContact({required int id});
  Future<void> storeContact({required ContactEntity contact});
  Future<List<ContactEntity>> getAllContacts();
  Future<void> storeImage({required Uint8List image, required int? id});
  Future<Uint8List> getImage({required int? id});
}

class ContacstLocalDataSourceImpl extends ContactsLocalDataSource {
  late Box _box;
  ContacstLocalDataSourceImpl() {
    _box = Hive.box(APP_BOX);
  }

  @override
  Future<void> deleteContacts({required List<ContactEntity> contacts}) async {
    await _box.deleteAll(contacts.map((c) => c.id));
  }

  @override
  Future<List<ContactEntity>> getAllContacts() async =>
      _box.values.whereType<ContactEntity>().toList();
  @override
  Future<void> storeListOfContacts(
      {required List<ContactEntity> contacts}) async {
    for (var contact in contacts) {
      await _box.put(contact.id, contact);
    }
  }

  @override
  Future<void> storeContact({required ContactEntity contact}) async {
    await _box.put(contact.id, contact);
  }

  @override
  Future<ContactEntity> getContact({required int id}) {
    try {
      return _box.get(id);
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> deleteContact({required int id}) async {
    await _box.delete(id);
  }

  @override
  Future<Uint8List> getImage({required int? id}) async {
    try {
      return await _box.get('Contacts/$id');
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> storeImage(
      {required Uint8List image, required int? id}) async {
    try {
      if (id == null) return;
      await _box.put('Contacts/$id', image);
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }
}
