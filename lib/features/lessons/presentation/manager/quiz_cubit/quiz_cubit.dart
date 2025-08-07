import '../../../data/repos/quiz_repo_imp.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/quiz_entity.dart';
part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit({required this.quizRepoImp}) : super(QuizInitialState());
  final QuizRepoImp quizRepoImp;

  Future<void> getQuizzes({
    required int lessonId,
  }) async {
    emit(QuizLoadingState());

    final result = await quizRepoImp.getQuizzes(lessonId: lessonId);

    result.fold(
      (failure) => emit(QuizErrorState(message: failure.errMessage)),
      (quizzes) => emit(QuizLoadedState(quizzes: quizzes)),
    );
  }
}
