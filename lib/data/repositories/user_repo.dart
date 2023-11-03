import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza/data/model/mymodels/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeUserData(UserModel user) async {
    try {
      // Use the user's ID as the document ID when storing user data
      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      throw Exception('Error storing user data: $e');
    }
  }

// You can add methods for fetching user data, updating user data, and more as needed.
}
