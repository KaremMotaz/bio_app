import 'failure.dart';

class CacheFailure extends Failure {
  const CacheFailure(super.errMessage);

  /// Factory methods for common cases
  factory CacheFailure.empty() =>
      const CacheFailure("No cached data found");

  factory CacheFailure.invalidFormat() =>
      const CacheFailure("Invalid cached data format");

  factory CacheFailure.writeError() =>
      const CacheFailure("Failed to write data to cache");

  factory CacheFailure.unknown([String? details]) =>
      CacheFailure("Unexpected cache error ${details ?? ""}");
}
