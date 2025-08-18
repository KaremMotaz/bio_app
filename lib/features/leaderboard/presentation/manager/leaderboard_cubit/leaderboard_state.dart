part of 'leaderboard_cubit.dart';

abstract class LeaderboardState {}

class LeaderboardInitialState extends LeaderboardState {}

class LeaderboardLoadingState extends LeaderboardState {}

class LeaderboardLoadedState extends LeaderboardState {
  final List<UserEntity> users;
  LeaderboardLoadedState({required this.users});
}

class LeaderboardErrorState extends LeaderboardState {
  final String message;
  LeaderboardErrorState({required this.message});
}
