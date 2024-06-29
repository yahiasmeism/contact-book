import 'package:contact_book/core/constants/messages.dart';
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
    await _box.deleteAll(contacts.map((c) => 'Contacts/${c.id}'));
  }

  @override
  Future<List<ContactEntity>> getAllContacts() async {
    final List<ContactEntity> contacts = [];
    final keys = _box.keys.map((k) => k.toString());
    final List<String> filterContactsKey =
        keys.where((k) => k.startsWith('Contacts')).toList();

    for (var contactKey in filterContactsKey) {
      if (_box.containsKey(contactKey)) {
        final contact = await _box.get(contactKey) as ContactEntity;
          contacts.add(contact);
      }
    }

    return contacts;
  }

  @override
  Future<void> storeListOfContacts(
      {required List<ContactEntity> contacts}) async {
    for (var contact in contacts) {
      await _box.put('Contacts/${contact.id}', contact);
    }
  }

  @override
  Future<void> storeContact({required ContactEntity contact}) async {
    await _box.put('Contacts/${contact.id}', contact);
  }

  @override
  Future<ContactEntity> getContact({required int id}) {
    try {
      return _box.get('Contacts/$id');
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> deleteContact({required int id}) async {
    await _box.delete('Contacts/$id');
  }

  @override
  Future<Uint8List> getImage({required int? id}) async {
    if (_box.containsKey('Image/$id')) {
      return await _box.get('Image/$id');
    } else {
      throw EmptyChacheException(MESSAGES.NOT_FOUND);
    }
  }

  @override
  Future<void> storeImage({required Uint8List image, required int? id}) async {
    try {
      if (id == null) return;
      await _box.put('Image/$id', image);
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }
}
