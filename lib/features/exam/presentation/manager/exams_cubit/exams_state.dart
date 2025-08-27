import 'package:equatable/equatable.dart';

import '../../../domain/entities/exam_entity.dart';

sealed class ExamsState extends Equatable {
  const ExamsState();

  @override
  List<Object?> get props => [];
}

final class ExamsInitialState extends ExamsState {}

final class ExamsLoadingState extends ExamsState {}

final class ExamsLoadedState extends ExamsState {
  final List<ExamEntity> availableExams;
  final List<ExamEntity> pastExams;

  const ExamsLoadedState({
    required this.availableExams,
    required this.pastExams,
  });

  @override
  List<Object?> get props => [availableExams, pastExams];
}

final class ExamsErrorState extends ExamsState {
  final String message;

  const ExamsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
