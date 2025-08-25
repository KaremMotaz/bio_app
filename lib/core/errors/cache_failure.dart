import 'failure.dart';

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code = "CACHE_FAILURE",
  });

  factory CacheFailure.empty() =>
      const CacheFailure(message: "No cached data found");

  factory CacheFailure.invalidFormat() =>
      const CacheFailure(message: "Invalid cached data format");

  factory CacheFailure.writeError() =>
      const CacheFailure(message: "Failed to write data to cache");

  factory CacheFailure.unknown([String? details]) => CacheFailure(
    message: "Unexpected cache error ${details ?? ""}",
  );
}
