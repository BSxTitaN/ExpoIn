import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Design-System/transitions.dart';

class CustomAuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(content),
      ),
    );
  }

  // Sign in with phone number
  Future<void> signInWithPhone(
      BuildContext context,
      String phoneNumber,
      Function() onVerificationSuccess,
      ) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted:
            (PhoneAuthCredential phoneAuthCredential) async {},
        verificationFailed: (error) {
          showSnackBar(context, error.message.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          // Navigator.of(context).push(
          //   createRoute(
          //     // OTPScreen(
          //     //   phone: phoneNumber,
          //     //   verficationId: verificationId,
          //     // ),
          //   ),
          // );
          onVerificationSuccess();
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (verificationId) {
          showSnackBar(context, 'OTP retrieval timed out. Please try again.');
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // Resend OTP
  Future<void> reInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted:
            (PhoneAuthCredential phoneAuthCredential) async {},
        verificationFailed: (error) {
          showSnackBar(context, error.message.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          showSnackBar(context, 'Code has been resent!');
        },
        timeout: const Duration(seconds: 30),
        codeAutoRetrievalTimeout: (verificationId) {
          showSnackBar(context, 'OTP retrieval timed out. Please try again.');
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // Verify OTP
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(creds);

      if (userCredential.user != null) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle({
    required BuildContext context,
    required Function onSuccess,
  }) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled Google Sign-In
        notifyListeners();
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Google credential
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Successful Google Sign-In
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    } catch (e) {
      showSnackBar(context, 'An error occurred during Google Sign-In.');
    } finally {
      notifyListeners();
    }
  }

  // Sign out
  Future<void> userSignOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}
