import 'dart:typed_data';

abstract  class ImageCacheManager {
 static final Map<String, Uint8List> _cachedImages = {};

  static Uint8List? getImage(String key) {
    if (_cachedImages.containsKey(key)) {
      return _cachedImages[key];
    }
    return null;
  }

 static void cacheImage(Uint8List image, String key) {
    _cachedImages[key] = image;
  }
 static void deleteImage(String key) {
    _cachedImages.remove(key);
  }

 static bool isExist(String key) {
    return _cachedImages.containsKey(key);
  }
}
