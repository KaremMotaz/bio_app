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

  int get index {
    switch (this) {
      case LeaderboardType.weekly:
        return 0;
      case LeaderboardType.daily:
        return 1;
      case LeaderboardType.monthly:
        return 2;
    }
  }

  static LeaderboardType fromIndex(int index) {
    switch (index) {
      case 0:
        return LeaderboardType.weekly;
      case 1:
        return LeaderboardType.daily;
      case 2:
        return LeaderboardType.monthly;
      default:
        return LeaderboardType.daily;
    }
  }
}
