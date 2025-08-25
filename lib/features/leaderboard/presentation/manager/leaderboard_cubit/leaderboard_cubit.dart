import 'dart:async';
import '../../../../auth/domain/user_entity.dart';
import '../../../domain/leaderboard_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final LeaderboardRepo leaderboardRepo;

  StreamSubscription? _sub;

  LeaderboardCubit({required this.leaderboardRepo})
    : super(LeaderboardInitialState());

  void loadNow() {
    emit(LeaderboardLoadingState());
    _sub?.cancel();
    _sub = leaderboardRepo.getTop10Now().listen((either) {
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
    _sub = leaderboardRepo.getTop10Week().listen((either) {
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
    _sub = leaderboardRepo.getTop10Month().listen((either) {
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
