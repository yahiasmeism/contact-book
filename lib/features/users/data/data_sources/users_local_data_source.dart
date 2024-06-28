import '../../../../core/constants/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user_entity.dart';
import 'package:hive/hive.dart';

abstract interface class UsersLocalDataSource {
  Future<void> storeAllUsers({required List<UserEntity> users});
  Future<void> storeUser({required String id, required UserEntity user});
  Future<void> deleteUsers({required List<UserEntity> users});
  Future<List<UserEntity>> getAllUsers();
  Future<UserEntity> getCurrentUser();
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  late Box _box;
  UsersLocalDataSourceImpl() {
    _box = Hive.box(APP_BOX);
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    try {
      return _box.get(CURRENT_USER_KEY);
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    return _box.values.whereType<UserEntity>().toList();
  }

  @override
  Future<void> storeAllUsers({required List<UserEntity> users}) async {
    try {
      for (var user in users) {
        await _box.put(user.id, user);
      }
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> storeUser({required String id, required UserEntity user}) async {
    try {
      await _box.put(id, user);
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> deleteUsers({required List<UserEntity> users}) async {
    try {
      await _box.deleteAll(users.map((user) => user.id));
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }
}
