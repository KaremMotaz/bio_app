import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/core/helpers/get_user.dart';
import 'package:bio_app/features/settings/data/review_model.dart';
import 'package:bio_app/features/settings/data/settings_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'review_app_state.dart';

class ReviewAppCubit extends Cubit<ReviewAppState> {
  ReviewAppCubit({required this.settingsRepo})
      : super(const ReviewAppInitialState());

  final SettingsRepo settingsRepo;

  void setRating({required double userRating}) {
    emit(ReviewAppInitialState(userRating: userRating));
  }

  Future<void> submitReview({required String content}) async {
    emit(ReviewAppLoadingState(userRating: state.userRating));

    final Either<Failure, Unit> result =
        await settingsRepo.submitReview(
      reviewModel: ReviewModel(
        rating: state.userRating,
        content: content,
        userId: getUser().uid!,
      ),
    );

    result.fold(
      (failure) {
        emit(ReviewAppFailureState(
          message: failure.message,
          userRating: state.userRating,
        ));
      },
      (_) {
        emit(ReviewAppSuccessState(userRating: state.userRating));
      },
    );
  }
}

