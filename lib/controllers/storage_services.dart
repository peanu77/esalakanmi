import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final storage = FirebaseStorage.instance;

  Future uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);

    try {
      await storage.ref('image/$fileName').putFile(file);
    } on FirebaseStorage catch (e) {
      print(e);
    }
  }
}
