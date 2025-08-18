import 'dart:async';
import 'package:bio_app/features/auth/domain/user_entity.dart';
import 'package:bio_app/features/leaderboard/domain/leaderboard_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final LeaderboardRepo leaderboardRepository;

  StreamSubscription? _sub;

  LeaderboardCubit({required this.leaderboardRepository})
    : super(LeaderboardInitialState());

  void loadNow() {
    emit(LeaderboardLoadingState());
    _sub?.cancel();
    _sub = leaderboardRepository.getTop10Now().listen((either) {
      either.fold(
        (failure) =>
            emit(LeaderboardErrorState(message: failure.message)),
        (users) => emit(LeaderboardLoadedState(users: users)),
      );
    });
  }

  void loadWeek() {
    emit(LeaderboardLoadingState());
    _sub?.cancel();
    _sub = leaderboardRepository.getTop10Week().listen((either) {
      either.fold(
        (failure) =>
            emit(LeaderboardErrorState(message: failure.message)),
        (users) => emit(LeaderboardLoadedState(users: users)),
      );
    });
  }

  void loadMonth() {
    emit(LeaderboardLoadingState());
    _sub?.cancel();
    _sub = leaderboardRepository.getTop10Month().listen((either) {
      either.fold(
        (failure) =>
            emit(LeaderboardErrorState(message: failure.message)),
        (users) => emit(LeaderboardLoadedState(users: users)),
      );
    });
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
