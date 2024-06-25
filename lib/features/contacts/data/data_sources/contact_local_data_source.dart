import '../../domain/entities/contact_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constant.dart';
import '../models/contact_model.dart';

abstract interface class ContactLocalDataSource {
  Future<void> storeListOfContacts({required List<ContactModel> contacts});
  Future<ContactEntity> getContact({required int id});
  Future<void> deleteContacts({required List<ContactModel> contacts});
  Future<void> deleteContact({required int id});
  Future<void> storeContact({required ContactModel contact});
  Future<List<ContactEntity>> getAllContacts();
}

class ContactLocalDataSourceImpl extends ContactLocalDataSource {
  final SharedPreferences sharedPreferences;
  late Box _box;
  ContactLocalDataSourceImpl({required this.sharedPreferences}) {
    _box = Hive.box(APP_BOX);
  }

  @override
  Future<void> deleteContacts({required List<ContactModel> contacts}) async =>
      await _box.deleteAll(contacts.map((c) => c.id));

  @override
  Future<List<ContactEntity>> getAllContacts() async =>
      _box.values.whereType<ContactEntity>().toList();

  @override
  Future<void> storeListOfContacts(
          {required List<ContactModel> contacts}) async =>
      contacts.map((contact) async => await _box.put(contact.id, contact));

  @override
  Future<void> storeContact({required ContactModel contact}) async =>
      _box.put(contact.id, contact);

  @override
  Future<ContactEntity> getContact({required int id}) {
    return _box.get(id);
  }

  @override
  Future<void> deleteContact({required int id}) async {
    await _box.delete(id);
  }
}
