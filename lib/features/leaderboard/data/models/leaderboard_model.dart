import '../../domain/leaderboard_entity.dart';

class LeaderboardModel extends LeaderboardEntity {
  const LeaderboardModel({
    required super.id,
    required super.fullName,
    required super.score,
    required super.rank,
    required super.imageUrl,
    required super.avatarColor,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      score: json['score'] as double,
      rank: json['rank'] as int,
      imageUrl: json['imageUrl'] as String,
      avatarColor: json['avatarColor'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'score': score,
      'rank': rank,
      'imageUrl': imageUrl,
      'avatarColor': avatarColor,
    };
  }
}
