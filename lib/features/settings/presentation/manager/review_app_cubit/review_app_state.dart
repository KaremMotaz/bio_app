part of 'review_app_cubit.dart';

sealed class ReviewAppState extends Equatable {
  final double userRating;
  const ReviewAppState({this.userRating = 0.0});

  @override
  List<Object> get props => [userRating];
}

final class ReviewAppInitialState extends ReviewAppState {
  const ReviewAppInitialState({super.userRating = 0.0});
}

final class ReviewAppLoadingState extends ReviewAppState {
  const ReviewAppLoadingState({super.userRating});
}

final class ReviewAppSuccessState extends ReviewAppState {
  const ReviewAppSuccessState({super.userRating});
}

final class ReviewAppFailureState extends ReviewAppState {
  final String message;
  const ReviewAppFailureState({required this.message, super.userRating});

  @override
  List<Object> get props => [message, userRating];
}
