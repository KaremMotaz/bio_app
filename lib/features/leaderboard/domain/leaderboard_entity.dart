class LeaderboardEntity {
  final String id; 
  final String fullName;
  final double score;
  final int rank;
  final int avatarColor;
  final String? imageUrl;

  const LeaderboardEntity({
    required this.id,
    required this.fullName,
    required this.score,
    required this.rank,
    required this.imageUrl,
    required this.avatarColor,
  });
}
