import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';

import '../../../../core/constants/api.dart';
import '../../../../core/error/exceptions.dart';
import '../models/contact_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constant.dart';

abstract interface class ContactRemoteDataSource {
  Future<List<ContactModel>> getAllContacts();

  Future<void> deleteContacts({required List<ContactEntity> contacts});

  Future<ContactModel> getContact({required int id});

  Future<String> getImageUrl({required int id});

  Future<ContactModel> createContact({required ContactModel contactModel});

  Future<ContactModel> updateContact({required ContactModel contact});

  Future<void> deleteContact({required int id});

  Future<ContactModel> toggleFavorite({required ContactModel contact});
}

class ContactRemoteDataSourceImpl extends ContactRemoteDataSource {
  final Dio dio;
  final SharedPreferences sharedPreferences;
  ContactRemoteDataSourceImpl({
    required this.dio,
    required this.sharedPreferences,
  }) {
    // initail dio base options
    dio.options = BaseOptions(
      headers: {_authToken.key: _authToken.value},
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 3),
      sendTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
    );
  }
  MapEntry<String, String> get _authToken {
    return MapEntry(
      'Authorization',
      'bearer ${sharedPreferences.getString(ACCESS_TOKEN_KEY)}',
    );
  }

  @override
  Future<ContactModel> createContact(
      {required ContactModel contactModel}) async {
    try {
      final FormData formData = await contactModel.toFormData();
      Response response = await dio.post(API.CONTACTS, data: formData);
      return ContactModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<void> deleteContact({required int id}) async {
    try {
      await dio.delete("${API.CONTACTS}/$id");
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<void> deleteContacts({required List<ContactEntity> contacts}) async {
    final List<int?> identifiers = contacts.map((e) => e.id).toList();
    try {
      await dio.delete(API.CONTACTS, data: identifiers);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<List<ContactModel>> getAllContacts() async {
    try {
      Response response = await dio.get(API.CONTACTS);
      final contactMaps = response.data as List<Map<String, dynamic>>;
      final contactModels =
          contactMaps.map((json) => ContactModel.fromJson(json)).toList();
      return contactModels;
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<ContactModel> getContact({required int id}) async {
    try {
      Response response = await dio.get("${API.CONTACTS}/$id");
      return ContactModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<String> getImageUrl({required int id}) async {
    try {
      Response response = await dio.get("${API.CONTACTS}/$id/image-url");
      return response.data;
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<ContactModel> toggleFavorite({required ContactModel contact}) async {
    try {
      Response response =
          await dio.patch("${API.CONTACTS}/toggle-favorite/${contact.id}");
      return ContactModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<ContactModel> updateContact({required ContactModel contact}) async {
    try {
      Response response = await dio.put("${API.CONTACTS}/${contact.id}");
      return ContactModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }
}
