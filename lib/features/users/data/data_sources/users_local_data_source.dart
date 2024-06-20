import 'package:contact_book/core/constants/constant.dart';
import 'package:contact_book/core/error/exceptions.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';

abstract interface class UsersLocalDataSource {
  Future<void> storeUsers({required List<UserEntity> users});
  Future<List<UserEntity>> getAllUsers();
  Future<UserEntity> getCurrentUser();
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  late Box _box;
  UsersLocalDataSourceImpl() {
    _box = Hive.box(APP_BOX);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    if (_box.containsKey(USERS_KEY)) {
      return _box.get(CURRENT_USER_KEY)!;
    } else {
      throw DatabaseException('user not found');
    }
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    return _box.values.whereType<UserEntity>().toList();
  }

  @override
  Future<void> storeUsers({required List<UserEntity> users}) async {
    try {
      for (var user in users) {
        await _box.put(user.id, user);
      }
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }

}
