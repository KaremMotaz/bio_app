import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  static String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
    return credential.user;
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  Future<User> signinWithGoogle({
    required String serverClientId,
  }) async {
    final GoogleSignIn signIn = GoogleSignIn.instance;
    signIn.initialize(serverClientId: serverClientId);

    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    final GoogleSignInAuthentication googleAuth =
        googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return (await FirebaseAuth.instance.signInWithCredential(
      credential,
    )).user!;
  }

  Future<User> signinWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(
          loginResult.accessToken!.tokenString,
        );

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance.signInWithCredential(
      facebookAuthCredential,
    )).user!;
  }

  Future<void> sendLinkToResetPassword({
    required String email,
  }) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> sendEmailVerification() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  Future<void> logOut() async {
    await GoogleSignIn.instance.signOut();
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> deleteAccount({
    String? email,
    String? password,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'no-user',
        message: 'No user is currently signed in.',
      );
    }

    try {
      final providerId = user.providerData.isNotEmpty
          ? user.providerData.first.providerId
          : null;

      if (providerId == 'password') {
        if (email == null || password == null) {
          throw FirebaseAuthException(
            code: 'missing-credentials',
            message:
                'Email and password are required for re-authentication.',
          );
        }
        final credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
      } else if (providerId == 'google.com') {
        // Google user
        final googleUser = await GoogleSignIn.instance.authenticate();
        final googleAuth = googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        await user.reauthenticateWithCredential(credential);
      } else if (providerId == 'facebook.com') {
        // Facebook user
        final fbLogin = await FacebookAuth.instance.login();
        if (fbLogin.status != LoginStatus.success) {
          throw FirebaseAuthException(
            code: 'cancelled',
            message: 'Facebook sign-in was cancelled by user.',
          );
        }
        final credential = FacebookAuthProvider.credential(
          fbLogin.accessToken!.tokenString,
        );
        await user.reauthenticateWithCredential(credential);
      } else {
        throw FirebaseAuthException(
          code: 'unsupported-provider',
          message:
              'Re-authentication not implemented for this provider.',
        );
      }

      // 2️⃣ Delete user
      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to delete account: $e');
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }
}
