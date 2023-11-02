import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<User?> signInWithPhoneNumber(
      {required String phoneNumber,
      required Function(String verificationId, int? resendToken) codeSent,
      required Function(PhoneAuthCredential credential) verificationCompleted,
      required Function(FirebaseAuthException e) verificationFailed,
      required Function(String verificationId) codeAutoRetrievalTimeout}) async {
    try {
      // Start the phone number verification process
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        // timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print('Error verifying phone number: $e');
    }
    return null;
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
