import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FileConverter {
  static Future<Uint8List> fileToUint8List(File file) async {
    try {
      List<int> bytes = await file.readAsBytes();
      return Uint8List.fromList(bytes);
    } catch (e) {
      throw Exception('Failed to convert file to Uint8List: $e');
    }
  }

  static Future<File> unit8ListToFile(Uint8List bytes) async {
    // Get the temporary directory
    Directory tempDir = await getTemporaryDirectory();

    // Create a temporary file name
    String tempFilePath = '${tempDir.path}/temp_file.txt';

    // Create a File instance
    File file = File(tempFilePath);

    return await file.writeAsBytes(bytes);
  }
}
