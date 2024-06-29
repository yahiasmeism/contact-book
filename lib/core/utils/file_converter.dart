import 'dart:io';

import 'package:flutter/foundation.dart';

class FileConverter {
  static Future<Uint8List> fileToUint8List(File file) async {
    try {
      List<int> bytes = await file.readAsBytes();
      return Uint8List.fromList(bytes);
    } catch (e) {
      throw Exception('Failed to convert file to Uint8List: $e');
    }
  }

}
