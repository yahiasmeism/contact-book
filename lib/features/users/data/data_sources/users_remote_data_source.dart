import 'dart:developer';

import 'package:contact_book/core/constants/constant.dart';
import 'package:contact_book/core/error/exceptions.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:contact_book/core/constants/api.dart';

import '../models/user_model.dart';

abstract interface class UsersRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
  Future<UserModel> getCurrentUser();
  Future<UserModel> addUser({required UserModel userModel});
  Future<UserModel> updateUser({required UserModel userModel});
  Future<void> deleteUsers({required List<UserEntity> users});
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  SharedPreferences sharedPreferences;
  Dio dio;
  UsersRemoteDataSourceImpl({
    required this.sharedPreferences,
    required this.dio,
  }) {
    // initail dio base options

    dio.options = BaseOptions(
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
  Future<UserModel> addUser({required UserModel userModel}) async {
    try {
      Response response = await dio.post(
        options: Options(headers: {_authToken.key: _authToken.value}),
        API.USERS,
        data: userModel.toJson,
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ServerException(message: e.response!.data);
      } else {
        throw ServerException.fromDioException(e);
      }
    }
  }

  @override
  Future<void> deleteUsers({required List<UserEntity> users}) async {
    List<String?> userIDs = users.map((user) => user.id).toList();

    try {
      await dio.delete(
        API.USERS,
        data: userIDs,
        options: Options(headers: {_authToken.key: _authToken.value}),
      );
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      Response response = await dio.get(
        API.USERS,
        options: Options(headers: {_authToken.key: _authToken.value}),
      );
      final usersJsonList = response.data as List<dynamic>;
      log("current user: ${(await getCurrentUser()).firstName}");
      return usersJsonList.map(
        (userJson) {
          return UserModel.fromJson(userJson);
        },
      ).toList();
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      Response response = await dio.get(
        API.CURRENT_USER,
        options: Options(headers: {_authToken.key: _authToken.value}),
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<UserModel> updateUser({required UserModel userModel}) async {
    try {
      String url = '${API.USERS}/${userModel.id}';
      Response response = await dio.put(url,
          options: Options(headers: {_authToken.key: _authToken.value}),
          data: userModel.toJson);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }
}
