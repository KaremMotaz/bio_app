import 'failure.dart';

class AuthFailure extends Failure {
  AuthFailure({required super.message, super.code = "AUTH_FAILURE"});

  factory AuthFailure.fromCode(String code) {
    switch (code) {
      case "invalid-email":
        return AuthFailure(
          message: "The email address is badly formatted.",
        );
      case "user-not-found":
        return AuthFailure(message: "No user found with this email.");
      case "wrong-password":
        return AuthFailure(message: "The password is incorrect.");
      case "email-already-in-use":
        return AuthFailure(
          message: "This email is already in use by another account.",
        );
      case "weak-password":
        return AuthFailure(
          message:
              "The password is too weak. Try a stronger password.",
        );
      case "user-disabled":
        return AuthFailure(
          message: "This user account has been disabled.",
        );
      case "too-many-requests":
        return AuthFailure(
          message: "Too many login attempts. Try again later.",
        );
      case "operation-not-allowed":
        return AuthFailure(
          message: "This authentication method is not enabled.",
        );
      case "network-request-failed":
        return AuthFailure(
          message: "A network error occurred. Check your connection.",
        );
      case "invalid-credential":
        return AuthFailure(
          message: "The credential provided is invalid or expired.",
        );
      case "account-exists-with-different-credential":
        return AuthFailure(
          message:
              "An account already exists with a different sign-in method.",
        );
      case "requires-recent-login":
        return AuthFailure(
          message:
              "This action requires recent authentication. Please log in again.",
        );
      case "provider-already-linked":
        return AuthFailure(
          message: "This provider is already linked to the account.",
        );
      case "credential-already-in-use":
        return AuthFailure(
          message:
              "This credential is already associated with another account.",
        );
      case "invalid-verification-code":
        return AuthFailure(
          message: "The verification code entered is invalid.",
        );
      case "invalid-verification-id":
        return AuthFailure(
          message: "The verification ID is invalid.",
        );
      default:
        return AuthFailure(
          message: "An unknown authentication error occurred.",
        );
    }
  }
}
