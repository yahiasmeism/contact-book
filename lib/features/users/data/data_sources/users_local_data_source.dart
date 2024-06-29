import '../../../../core/constants/constant.dart';
import '../../../../core/constants/messages.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user_entity.dart';
import 'package:hive/hive.dart';

abstract interface class UsersLocalDataSource {
  Future<void> storeAllUsers({required List<UserEntity> users});
  Future<void> storeUser({required UserEntity user});
  Future<void> deleteUsers({required List<UserEntity> users});
  Future<List<UserEntity>> getAllUsers();
  Future<void> storeCurrentUser({required UserEntity user});
  Future<UserEntity> getCurrentUser();
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  late Box _box;
  UsersLocalDataSourceImpl() {
    _box = Hive.box(APP_BOX);
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    final List<UserEntity> users = [];
    final keys = _box.keys.map((k) => k.toString());
    final List<String> filterUsersKey =
        keys.where((k) => k.startsWith('Users')).toList();

    for (var userKey in filterUsersKey) {
      final user = await _box.get(userKey) as UserEntity?;
      if (user != null) {
        users.add(user);
      }
    }

    return users;
  }

  @override
  Future<void> storeAllUsers({required List<UserEntity> users}) async {
    try {
      for (var user in users) {
        await _box.put('Users/${user.id}', user);
      }
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> storeUser({required UserEntity user}) async {
    try {
      await _box.put('Users/${user.id}', user);
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> deleteUsers({required List<UserEntity> users}) async {
    try {
      await _box.deleteAll(users.map((user) => "Users/${user.id}"));
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    if (_box.containsKey(CURRENT_USER_KEY)) {
      return await _box.get(CURRENT_USER_KEY);
    } else {
      throw EmptyChacheException(MESSAGES.NOT_FOUND);
    }
  }

  @override
  Future<void> storeCurrentUser({required UserEntity user}) async {
    try {
      await _box.put(CURRENT_USER_KEY, user);
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }
}
