import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code = "SERVER_FAILURE",
  });

  factory ServerFailure.fromResponse(
    int statusCode,
    dynamic response,
  ) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(message: response['error']['message']);
    } else if (statusCode == 404) {
      return const ServerFailure(
        message:
            "Your request was not found, please try again later!",
      );
    } else if (statusCode == 500) {
      return const ServerFailure(
        message: "Internal server error, please try again later!",
      );
    } else {
      return const ServerFailure(
        message: "Oops, there was an error. Please try again later!",
      );
    }
  }


  factory ServerFailure.fromFirebaseException(FirebaseException e) {
    return ServerFailure(
      message: e.message ?? "Unexpected Firebase error occurred.",
    );
  }


  factory ServerFailure.fromPlatformException(PlatformException e) {
    return ServerFailure(
      message: e.message ?? "A platform error occurred.",
    );
  }

  factory ServerFailure.unknown([String? details]) => ServerFailure(
    message: "Unexpected server error ${details ?? ""}",
  );
}
