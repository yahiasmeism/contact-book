import 'package:contact_book/core/constants/constant.dart';
import 'package:contact_book/core/error/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:contact_book/core/constants/api.dart';

import '../models/user_model.dart';

abstract interface class UsersRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
  Future<UserModel> getCurrentUser();
  Future<UserModel> getUser({required String id});
  Future<void> addUser({required UserModel userModel});
  Future<UserModel> updateUser({required UserModel userModel});
  Future<void> deleteUser({required String id});
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  SharedPreferences sharedPreferences;
  Dio dio;
  UsersRemoteDataSourceImpl({
    required this.sharedPreferences,
    required this.dio,
  }) {
    // initail dio base options
    String bearerToken =
        'bearer ${sharedPreferences.getString(ACCESS_TOKEN_KEY)}';
    dio.options = BaseOptions(
      headers: {'Authorization': bearerToken},
    );
  }

  @override
  Future<void> addUser({required UserModel userModel}) async {
    try {
      await dio.post(
        API.USERS,
        data: userModel.toJson(),
      );
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<void> deleteUser({required String id}) async {
    try {
      await dio.delete('${API.USERS}/$id');
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      Response response = await dio.get(API.USERS);
      final usersJsonList = response.data as List<dynamic>;
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
      Response response = await dio.get(API.CURRENT_USER);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<UserModel> getUser({required String id}) async {
    try {
      Response response = await dio.get('${API.USERS}/$id');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<UserModel> updateUser({required UserModel userModel}) async {
    try {
      Response response = await dio.put(
        API.USERS,
        data: userModel.toJson(),
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }
}
