import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
}

class ContacstLocalDataSourceImpl extends ContactsLocalDataSource {
  final CacheManager cacheManager;
  late Box _box;
  ContacstLocalDataSourceImpl({required this.cacheManager}) {
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
    return _box.get(id);
  }

  @override
  Future<void> deleteContact({required int id}) async {
    await _box.delete(id);
  }
}
