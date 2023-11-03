import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizza/utils/logging/logger.dart';

// Authentication User Cubit
class AuthUserCubit extends Cubit<User?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthUserCubit() : super(null) {
    _init();
  }

  void _init() {
    // Listen to authentication state changes
    _auth.authStateChanges().listen((User? user) {
      TLoggerHelper.info("User changed: $user");
      emit(user);
    });
  }

  // Sign out the user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
