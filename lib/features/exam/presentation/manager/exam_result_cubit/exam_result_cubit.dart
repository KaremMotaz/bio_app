import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exam_result_state.dart';

class ExamResultCubit extends Cubit<ExamResultState> {
  ExamResultCubit() : super(ExamResultInitial());
}
