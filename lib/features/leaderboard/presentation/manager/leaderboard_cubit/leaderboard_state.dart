part of 'leaderboard_cubit.dart';

abstract class LeaderboardState {}

class LeaderboardInitialState extends LeaderboardState {}

class LeaderboardLoadingState extends LeaderboardState {}

class LeaderboardLoadedState extends LeaderboardState {
  final List<UserEntity> users;
  final LeaderboardType type;

  LeaderboardLoadedState({required this.users, required this.type});
}

class LeaderboardErrorState extends LeaderboardState {
  final String message;
  LeaderboardErrorState({required this.message});
}
