import 'package:contact_book/core/constants/constant.dart';
import 'package:contact_book/core/error/exceptions.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';

abstract interface class UsersLocalDataSource {
  Future<void> storeUsers({required List<UserModel> users});
  Future<List<UserEntity>> getAllUsers();
  Future<UserEntity> getUser({required String id});
  Future<UserEntity> updateUser({required UserEntity userModel});
  Future<void> deleteUsers({required List<String> usersId});
  Future<UserEntity> getCurrentUser();
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  late Box _box;
  UsersLocalDataSourceImpl() {
    _box = Hive.box(APP_BOX);
  }

  @override
  Future<void> deleteUsers({required List<String> usersId}) async {
    for (var userID in usersId) {
      if (_box.containsKey(userID)) {
        await _box.delete(userID);
      }
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    return await _getUserByKey(CURRENT_USER_KEY);
  }

  @override
  Future<UserModel> getUser({required String id}) async {
    return await _getUserByKey(id);
  }


  @override
  Future<List<UserEntity>> getAllUsers() async {
    return _box.values.whereType<UserEntity>().toList();
  }

  @override
  Future<void> storeUsers({required List<UserModel> users}) async {
    for (var user in users) {
      await _storeOrUpdate(user);
    }
  }

  @override
  Future<UserEntity> updateUser({required UserEntity userModel}) async {
    return await _storeOrUpdate(userModel);
  }

  /// If the user does not exist it will be stored
  /// otherwise it will be updated
  Future<UserEntity> _storeOrUpdate(UserEntity user) async {
    try {
      await _box.put(user.id, user);
      return user;
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  /// get user by key
  Future<UserModel> _getUserByKey(String key) async {
    if (_box.containsKey(USERS_KEY)) {
      return _box.get(USERS_KEY)!;
    } else {
      throw DatabaseException('user not found');
    }
  }
}
