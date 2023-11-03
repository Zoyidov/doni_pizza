import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza/utils/logging/logger.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      return authResult.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authResult.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      TLoggerHelper.error('Error registering with email and password: $e');
      throw Exception('Error registering with email and password: $e');
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authResult.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      TLoggerHelper.error('Error signing in with email and password: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
