part of 'report_bug_cubit.dart';

sealed class ReportBugState extends Equatable {
  const ReportBugState();

  @override
  List<Object> get props => [];
}

final class ReportBugInitialState extends ReportBugState {}

final class ReportBugLoadingState extends ReportBugState {}

final class ReportBugSuccessState extends ReportBugState {}

final class ReportBugFailureState extends ReportBugState {
  final String message;
  const ReportBugFailureState({required this.message});
}
