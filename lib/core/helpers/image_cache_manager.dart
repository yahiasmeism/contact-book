import 'dart:typed_data';

class ImageCacheManager {
  final Map<String, Uint8List> _cachedImages = {};

  Uint8List? getImage(String key) {
    if (_cachedImages.containsKey(key)) {
      return _cachedImages[key];
    }
    return null;
  }

  void cacheImage(Uint8List image, String key) {
    _cachedImages[key] = image;
  }

  bool isExist(String key) {
    return _cachedImages.containsKey(key);
  }
}
