import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String imageUrl;
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.password,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? imageUrl,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'password': password,
    };
  }

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      id: snapshot.id,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      imageUrl: map['imageUrl'] as String,
      password: map['password'] as String,
    );
  }
}
