

import 'failure.dart';

class AuthFailure extends Failure {
  AuthFailure(super.errMessage);

  factory AuthFailure.fromCode(String code) {
    switch (code) {
      case "invalid-email":
        return AuthFailure("The email address is badly formatted.");
      case "user-not-found":
        return AuthFailure("No user found with this email.");
      case "wrong-password":
        return AuthFailure("The password is incorrect.");
      case "email-already-in-use":
        return AuthFailure("This email is already in use by another account.");
      case "weak-password":
        return AuthFailure("The password is too weak. Try a stronger password.");
      case "user-disabled":
        return AuthFailure("This user account has been disabled.");
      case "too-many-requests":
        return AuthFailure("Too many login attempts. Try again later.");
      case "operation-not-allowed":
        return AuthFailure("This authentication method is not enabled.");
      case "network-request-failed":
        return AuthFailure("A network error occurred. Check your connection.");
      case "invalid-credential":
        return AuthFailure("The credential provided is invalid or expired.");
      case "account-exists-with-different-credential":
        return AuthFailure("An account already exists with a different sign-in method.");
      case "requires-recent-login":
        return AuthFailure("This action requires recent authentication. Please log in again.");
      case "provider-already-linked":
        return AuthFailure("This provider is already linked to the account.");
      case "credential-already-in-use":
        return AuthFailure("This credential is already associated with another account.");
      case "invalid-verification-code":
        return AuthFailure("The verification code entered is invalid.");
      case "invalid-verification-id":
        return AuthFailure("The verification ID is invalid.");
      default:
        return AuthFailure("An unknown authentication error occurred.");
    }
  }
}
