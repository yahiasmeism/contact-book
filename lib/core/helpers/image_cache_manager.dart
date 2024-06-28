import 'dart:io';

import 'package:contact_book/core/constants/api.dart';
import 'package:contact_book/core/constants/constant.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageCacheManager {
  static Future<File?> getImage({required String? imageUrl}) async {
    if (imageUrl == null) return null;
    final imageUrlWithBaseUrl = "${API.BASE_URL}$imageUrl";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(ACCESS_TOKEN_KEY);
    Map<String, String> headers = {'Authorization': 'bearer $token'};
    final file = await DefaultCacheManager().getSingleFile(
      imageUrlWithBaseUrl,
      headers: headers,
    );
    return file;
  }
}
