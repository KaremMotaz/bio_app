part of 'app_rating_cubit.dart';

sealed class AppRatingState extends Equatable {
  final double? userRating;
  const AppRatingState({this.userRating});

  @override
  List<Object?> get props => [userRating];
}

final class AppRatingInitialState extends AppRatingState {
  const AppRatingInitialState({super.userRating});
}

final class AppRatingLoadingState extends AppRatingState {
  const AppRatingLoadingState({super.userRating});
}

final class AppRatingNotRatedState extends AppRatingState {
  const AppRatingNotRatedState({super.userRating});
}

final class AppRatingRatedState extends AppRatingState {
  const AppRatingRatedState({required super.userRating});
}

final class AppRatingFailureState extends AppRatingState {
  final String message;
  const AppRatingFailureState({
    required this.message,
    super.userRating,
  });

  @override
  List<Object?> get props => [message, userRating];
}
