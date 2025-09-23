import '../../../../../core/errors/failure.dart';
import '../../../../../core/helpers/constants.dart';
import '../../../../../core/helpers/get_user.dart';
import '../../../../../core/services/cache_helper.dart';
import '../../../data/models/app_rating_model.dart';
import '../../../data/settings_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_rating_state.dart';

class AppRatingCubit extends Cubit<AppRatingState> {
  AppRatingCubit({required this.settingsRepo})
    : super(const AppRatingInitialState()) {
    _loadUserRating();
  }

  final SettingsRepo settingsRepo;

  void setUserRating({required double userRating}) {
    emit(AppRatingInitialState(userRating: userRating));
  }

  Future<void> _loadUserRating() async {
    final rating = CacheHelper.getDouble(key: kUserRating);
    if (rating != null) {
      emit(AppRatingRatedState(userRating: rating));
    } else {
      emit(const AppRatingNotRatedState());
    }
  }

  void resetRating() {
    emit(const AppRatingNotRatedState());
  }

  Future<void> submitAppRating() async {
    emit(AppRatingLoadingState(userRating: state.userRating));

    final Either<Failure, Unit> result = await settingsRepo
        .submitAppRating(
          appRatingModel: AppRatingModel(
            rating: state.userRating,
            userId: getUser().uid!,
          ),
        );

    result.fold(
      (failure) {
        emit(
          AppRatingFailureState(
            message: failure.message,
            userRating: state.userRating,
          ),
        );
      },
      (_) {
        emit(AppRatingRatedState(userRating: state.userRating));
      },
    );
  }

  Future<void> getAppRating() async {
    emit(AppRatingLoadingState(userRating: state.userRating));

    final Either<Failure, AppRatingModel> result = await settingsRepo
        .getAppRating();

    result.fold(
      (failure) {
        emit(
          AppRatingFailureState(
            message: failure.message,
            userRating: state.userRating,
          ),
        );
      },
      (ratingModel) {
        if (ratingModel.rating == null) {
          emit(const AppRatingNotRatedState());
        } else {
          emit(AppRatingRatedState(userRating: ratingModel.rating!));
        }
      },
    );
  }
}
