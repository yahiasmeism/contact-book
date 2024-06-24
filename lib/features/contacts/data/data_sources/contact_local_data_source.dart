import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../models/contact_model.dart';

abstract interface class ContactLocalDataSource {
  Future<void> storeListOfContacts({required List<ContactModel> contacts});
  Future<void> deleteContacts({required List<ContactModel> contacts});
  Future<void> storeContact({required ContactModel contact});
  Future<List<ContactEntity>> getAllContacts();
}

class ContactLocalDataSourceImpl extends ContactLocalDataSource {
  late Box _box;
  ContactLocalDataSourceImpl() {
    _box = Hive.box(APP_BOX);
  }

  @override
  Future<void> deleteContacts({required List<ContactModel> contacts}) async =>
      await _box.deleteAll(contacts.map((c) => c.id));

  @override
  Future<List<ContactEntity>> getAllContacts() async =>
      _box.values.whereType<ContactEntity>().toList();

  @override
  Future<void> storeListOfContacts({required List<ContactModel> contacts}) async =>
      contacts.map((contact) async => await _box.put(contact.id, contact));

  @override
  Future<void> storeContact({required ContactModel contact}) async =>
      _box.put(contact.id, contact);
}
