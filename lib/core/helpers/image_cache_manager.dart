import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCacheManager {
  static Future<File> getImage({required String imageUrl,String? token}) async {
    final file = await DefaultCacheManager().getSingleFile(
      imageUrl,
      headers: {'Authorization': 'bearer $token'},
    );
    return file;
  }
}
