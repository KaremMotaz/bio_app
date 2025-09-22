part of 'review_app_cubit.dart';

sealed class ReviewAppState extends Equatable {
  const ReviewAppState();

  @override
  List<Object> get props => [];
}

final class ReviewAppInitialState extends ReviewAppState {}

final class ReviewAppLoadingState extends ReviewAppState {}

final class ReviewAppSuccessState extends ReviewAppState {}

final class ReviewAppFailureState extends ReviewAppState {
  final String message;
  const ReviewAppFailureState({required this.message});
}
