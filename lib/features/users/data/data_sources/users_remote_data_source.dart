import 'dart:convert';

import 'package:contact_book/core/network/api_client.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user_entity.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/api.dart';

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
  ApiClient apiClient;
  UsersRemoteDataSourceImpl(
      {required this.sharedPreferences, required this.apiClient});

  String? get _authToken {
    return sharedPreferences.getString(ACCESS_TOKEN_KEY);
  }

  @override
  Future<UserModel> addUser({required UserModel userModel}) async {
    Response response = await apiClient.post(
      token: _authToken,
      API.USERS,
      data: userModel.toJson,
    );
    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> deleteUsers({required List<UserEntity> users}) async {
    List<String?> userIDs = users.map((user) => user.id).toList();
    await apiClient.delete(API.USERS,
        data: jsonEncode(userIDs), token: _authToken);
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    Response response = await apiClient.get(API.USERS, token: _authToken);
    final usersJsonList = response.data as List<dynamic>;
    return usersJsonList.map((userJson) {
      return UserModel.fromJson(userJson);
    }).toList();
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      Response response =
          await apiClient.get(API.CURRENT_USER, token: _authToken);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<UserModel> updateUser({required UserModel userModel}) async {
    String url = '${API.USERS}/${userModel.id}';
    Response response =
        await apiClient.put(url, token: _authToken, data: userModel.toJson);
    return UserModel.fromJson(response.data);
  }
}
