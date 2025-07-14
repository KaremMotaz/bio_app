import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit() : super(ExamInitial());
}
