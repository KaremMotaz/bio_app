import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit() : super(LeaderboardInitial());
}
