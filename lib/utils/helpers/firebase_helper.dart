import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class TFirebaseHelper {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadImage(String filePath, String storagePath) async {
    final ref = _storage.ref().child(storagePath);

    try {
      final task = await ref.putFile(File(filePath));
      final url = await task.ref.getDownloadURL();
      return url;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  static Future<bool> checkIfImageExists(String imagePath) async {
    final ref = _storage.ref().child(imagePath);
    try {
      await ref.getDownloadURL();
      return true; // Image exists in Firebase Storage
    } catch (e) {
      return false; // Image does not exist in Firebase Storage
    }
  }
}
