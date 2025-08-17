import 'failure.dart';

class FirestoreFailure extends Failure {
  FirestoreFailure(super.message);

  factory FirestoreFailure.fromCode(String code) {
    switch (code) {
      case "permission-denied":
        return FirestoreFailure(
          "You do not have permission to perform this action.",
        );
      case "unavailable":
        return FirestoreFailure(
          "The service is temporarily unavailable. Please try again later.",
        );
      case "deadline-exceeded":
        return FirestoreFailure(
          "The request took too long. Please try again.",
        );
      case "not-found":
        return FirestoreFailure(
          "The requested document was not found.",
        );
      case "already-exists":
        return FirestoreFailure("This document already exists.");
      case "cancelled":
        return FirestoreFailure("The operation was cancelled.");
      case "invalid-argument":
        return FirestoreFailure("The provided argument is invalid.");
      case "resource-exhausted":
        return FirestoreFailure(
          "Too many requests. Please try again later.",
        );
      case "failed-precondition":
        return FirestoreFailure(
          "The request cannot be processed due to a failed condition.",
        );
      case "aborted":
        return FirestoreFailure("The operation was aborted.");
      case "out-of-range":
        return FirestoreFailure(
          "The value provided is out of range.",
        );
      case "data-loss":
        return FirestoreFailure("Data loss has occurred.");
      case "unauthenticated":
        return FirestoreFailure(
          "You need to be signed in to perform this action.",
        );
      default:
        return FirestoreFailure(
          "An unexpected error occurred. Please try again later.",
        );
    }
  }
}
