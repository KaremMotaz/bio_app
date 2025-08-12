class LeaderboardEntity {
  final String id;
  final String name;
  final int score;
  final int rank;
  final String avatarUrl;

  const LeaderboardEntity({
    required this.id,
    required this.name,
    required this.score,
    required this.rank,
    required this.avatarUrl,
  });
}
