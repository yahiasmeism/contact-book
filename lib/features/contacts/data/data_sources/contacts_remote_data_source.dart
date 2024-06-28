import 'dart:convert';
import 'package:contact_book/core/network/api_client.dart';
import 'package:contact_book/features/contacts/data/models/send_email_model.dart';
import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import '../../../../core/constants/api.dart';
import '../models/contact_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constant.dart';

abstract interface class ContactsRemoteDataSource {
  Future<List<ContactModel>> getAllContacts();

  Future<void> deleteContacts({required List<ContactEntity> contacts});

  Future<ContactModel> getContact({required int id});

  Future<ContactModel> createContact({required ContactModel contactModel});

  Future<ContactModel> updateContact({required ContactModel contact});

  Future<void> deleteContact({required int id});

  Future<ContactModel> toggleFavorite({required ContactModel contact});
  Future<void> sendEmail({required SendEmailModel sendEmail});
}

class ContactsRemoteDataSourceImpl extends ContactsRemoteDataSource {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ContactsRemoteDataSourceImpl({
    required this.apiClient,
    required this.sharedPreferences,
  });

  String? get _authToken {
    return sharedPreferences.getString(ACCESS_TOKEN_KEY);
  }

  @override
  Future<ContactModel> createContact(
      {required ContactModel contactModel}) async {
    final FormData formData = await contactModel.toFormData();
    Response response = await apiClient.post(
      API.CONTACTS,
      data: formData,
      token: _authToken,
    );
    return ContactModel.fromJson(response.data);
  }

  @override
  Future<void> deleteContact({required int id}) async {
    await apiClient.delete("${API.CONTACTS}/$id", token: _authToken);
  }

  @override
  Future<void> deleteContacts({required List<ContactEntity> contacts}) async {
    final List<int?> identifiers = contacts.map((e) => e.id).toList();
    var data = json.encode(identifiers);
    await apiClient.delete(API.CONTACTS, data: data, token: _authToken);
  }

  @override
  Future<List<ContactModel>> getAllContacts() async {
    Response response = await apiClient.get(API.CONTACTS, token: _authToken);
    final contactMaps = response.data as List<dynamic>;
    final contactModels =
        contactMaps.map((map) => ContactModel.fromJson(map)).toList();
    return contactModels;
  }

  @override
  Future<ContactModel> getContact({required int id}) async {
    Response response =
        await apiClient.get("${API.CONTACTS}/$id", token: _authToken);
    return ContactModel.fromJson(response.data);
  }

  @override
  Future<ContactModel> toggleFavorite({required ContactModel contact}) async {
    Response response = await apiClient.patch(
      "${API.CONTACTS}/toggle-favorite/${contact.id}",
      token: _authToken,
    );
    return ContactModel.fromJson(response.data);
  }

  @override
  Future<ContactModel> updateContact({required ContactModel contact}) async {
    final FormData formData = await contact.toFormData();
    Response response = await apiClient.put(
      "${API.CONTACTS}/${contact.id}",
      data: formData,
      token: _authToken,
    );
    return ContactModel.fromJson(response.data);
  }

  @override
  Future<void> sendEmail({required SendEmailModel sendEmail}) async {
    await apiClient.post(
      API.CONTACT_SEND_EMAIL,
      token: _authToken,
      data: sendEmail.toJson(),
    );
  }
}
