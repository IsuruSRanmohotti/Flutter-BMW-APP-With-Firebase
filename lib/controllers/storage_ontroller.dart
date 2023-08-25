import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageController {
  Future<String> uploadImage(File file, String path) async {
    final fileName = basename(file.path);
    final reference = FirebaseStorage.instance.ref("$path/$fileName");
    final uploadTask = reference.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }
}
