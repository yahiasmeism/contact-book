import 'package:contact_book/core/constants/constant.dart';
import 'package:contact_book/core/error/exceptions.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';

abstract interface class UsersLocalDataSource {
  Future<void> storeUsers({required List<UserModel> users});
  Future<void> storeUser({required UserModel user});
  Future<List<UserModel>> getAllUsers();
  Future<UserModel> getUser({required String id});
  Future<UserModel> updateUser({required UserModel userModel});
  Future<void> deleteUser({required String id});
  Future<UserModel> getCurrentUser();
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  late Box<UserModel> _box;
  UsersLocalDataSourceImpl() {
    _box = Hive.box<UserModel>(APP_BOX);
  }

  @override
  Future<void> deleteUser({required String id}) async {
    if (_box.containsKey(id)) {
      await _box.delete(id);
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
  Future<void> storeUser({required UserModel user}) async {
    await _storeOrUpdate(user);
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    return _box.values.toList();
  }

  @override
  Future<void> storeUsers({required List<UserModel> users}) async {
    for (var user in users) {
      await _storeOrUpdate(user);
    }
  }

  @override
  Future<UserModel> updateUser({required UserModel userModel}) async {
    return await _storeOrUpdate(userModel);
  }

  /// If the user does not exist it will be stored
  /// otherwise it will be updated
  Future<UserModel> _storeOrUpdate(UserModel user) async {
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
