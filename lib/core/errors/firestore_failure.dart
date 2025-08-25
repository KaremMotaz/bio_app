import 'failure.dart';

class FirestoreFailure extends Failure {
  FirestoreFailure({
    required super.message,
    super.code = "FIRESTORE_FAILURE",
  });

  factory FirestoreFailure.fromCode(String code) {
    switch (code) {
      case "permission-denied":
        return FirestoreFailure(
          message:
              "You do not have permission to perform this action.",
        );
      case "unavailable":
        return FirestoreFailure(
          message:
              "The service is temporarily unavailable. Please try again later.",
        );
      case "deadline-exceeded":
        return FirestoreFailure(
          message: "The request took too long. Please try again.",
        );
      case "not-found":
        return FirestoreFailure(
          message: "The requested document was not found.",
        );
      case "already-exists":
        return FirestoreFailure(
          message: "This document already exists.",
        );
      case "cancelled":
        return FirestoreFailure(
          message: "The operation was cancelled.",
        );
      case "invalid-argument":
        return FirestoreFailure(
          message: "The provided argument is invalid.",
        );
      case "resource-exhausted":
        return FirestoreFailure(
          message: "Too many requests. Please try again later.",
        );
      case "failed-precondition":
        return FirestoreFailure(
          message:
              "The request cannot be processed due to a failed condition.",
        );
      case "aborted":
        return FirestoreFailure(
          message: "The operation was aborted.",
        );
      case "out-of-range":
        return FirestoreFailure(
          message: "The value provided is out of range.",
        );
      case "data-loss":
        return FirestoreFailure(message: "Data loss has occurred.");
      case "unauthenticated":
        return FirestoreFailure(
          message: "You need to be signed in to perform this action.",
        );
      default:
        return FirestoreFailure(
          message:
              "An unexpected error occurred. Please try again later.",
        );
    }
  }
}
