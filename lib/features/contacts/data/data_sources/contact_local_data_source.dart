import '../models/contact_model.dart';

abstract interface class ContactLocalDataSource {
  Future<void> storeContacts({required List<ContactModel> cotnacts});
  Future<void> deleteContacts({required List<ContactModel> cotnacts});
  Future<void> updateContact({required ContactModel cotnacts});
  Future<List<ContactModel>> getAllContacts();
}
