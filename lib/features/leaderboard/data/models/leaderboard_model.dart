import 'package:bio_app/features/leaderboard/domain/leaderboard_entity.dart';

class LeaderboardModel extends LeaderboardEntity {
  const LeaderboardModel({
    required super.id,
    required super.name,
    required super.score,
    required super.rank,
    required super.avatarUrl,
    required super.savedColor,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      id: json['id'] as String,
      name: json['name'] as String,
      score: json['score'] as int,
      rank: json['rank'] as int,
      avatarUrl: json['avatarUrl'] as String,
      savedColor: json['savedColor'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'score': score,
      'rank': rank,
      'avatarUrl': avatarUrl,
    };
  }
}
