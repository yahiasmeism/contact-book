import 'dart:async';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthLocalDataSource {
  Future<bool> storeToken(String token);
  String? getToken();
  Future<void> clearAppData();
}

class AuthLocalDataSourceimpl implements AuthLocalDataSource {
  SharedPreferences sharedPreferences;
  AuthLocalDataSourceimpl({
    required this.sharedPreferences,
  });

  @override
  String? getToken() {
    if (sharedPreferences.containsKey(ACCESS_TOKEN_KEY)) {
      final token = sharedPreferences.getString(ACCESS_TOKEN_KEY);
      return token;
    }
    return null;
  }

  @override
  Future<bool> storeToken(String token) async {
    return await sharedPreferences.setString(ACCESS_TOKEN_KEY, token);
  }

  @override
  Future<void> clearAppData() async {
    await Hive.box(APP_BOX).clear();
    await sharedPreferences.clear();
    await DefaultCacheManager().emptyCache();
  }
}
