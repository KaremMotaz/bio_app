import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/domain/user_entity.dart';
import '../../../domain/leaderboard_repo.dart';
import '../../../domain/leaderboard_type.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final LeaderboardRepo leaderboardRepo;
  StreamSubscription? _sub;

  LeaderboardCubit({required this.leaderboardRepo})
    : super(LeaderboardInitialState());

  void load({required LeaderboardType type}) async {
    emit(LeaderboardLoadingState());
    _sub?.cancel();

    Stream stream;
    switch (type) {
      case LeaderboardType.daily:
        stream = leaderboardRepo.getTop10Now();
        break;
      case LeaderboardType.weekly:
        stream = leaderboardRepo.getTop10Week();
        break;
      case LeaderboardType.monthly:
        stream = leaderboardRepo.getTop10Month();
        break;
    }

    _sub = stream.listen((either) {
      either.fold(
        (failure) =>
            emit(LeaderboardErrorState(message: failure.message)),
        (users) =>
            emit(LeaderboardLoadedState(users: users, type: type)),
      );
    });
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
