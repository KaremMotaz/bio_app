import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/domain/user_entity.dart';
import '../../../domain/leaderboard_repo.dart';
import '../../../domain/leaderboard_type.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final LeaderboardRepo leaderboardRepo;
  StreamSubscription? _sub;

  final Map<LeaderboardType, List<UserEntity>> _cache = {};

  LeaderboardCubit({required this.leaderboardRepo})
    : super(LeaderboardInitialState());

  void load({required LeaderboardType type}) async {
    if (_cache.containsKey(type)) {
      emit(LeaderboardLoadedState(users: _cache[type]!, type: type));
    } else {
      emit(LeaderboardLoadingState());
    }

    _sub?.cancel();
    _sub = _getStream(type).listen((either) {
      either.fold(
        (failure) => emit(
          LeaderboardErrorState(message: failure.message, type: type),
        ),
        (users) {
          _cache[type] = users;
          emit(LeaderboardLoadedState(users: users, type: type));
        },
      );
    });
  }

  Stream<dynamic> _getStream(LeaderboardType type) {
    switch (type) {
      case LeaderboardType.daily:
        return leaderboardRepo.getTop10Now();
      case LeaderboardType.weekly:
        return leaderboardRepo.getTop10Week();
      case LeaderboardType.monthly:
        return leaderboardRepo.getTop10Month();
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
