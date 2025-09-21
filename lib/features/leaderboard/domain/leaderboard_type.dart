enum LeaderboardType { weekly, daily, monthly }

extension LeaderboardTypeX on LeaderboardType {
  String get label {
    switch (this) {
      case LeaderboardType.daily:
        return 'يومياً';
      case LeaderboardType.weekly:
        return 'اسبوعياً';
      case LeaderboardType.monthly:
        return 'شهرياً';
    }
  }
}