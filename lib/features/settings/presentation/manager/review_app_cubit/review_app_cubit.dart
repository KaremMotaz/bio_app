import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'review_app_state.dart';

class ReviewAppCubit extends Cubit<ReviewAppState> {
  ReviewAppCubit() : super(ReviewAppInitialState());

  void reviewApp() {
    emit(ReviewAppLoadingState());
    emit(ReviewAppSuccessState());
  }
}
