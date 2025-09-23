import 'package:bio_app/core/errors/failure.dart';
import 'package:bio_app/core/helpers/get_user.dart';
import 'package:bio_app/features/settings/data/report_model.dart';
import 'package:bio_app/features/settings/data/settings_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'report_bug_state.dart';

class ReportBugCubit extends Cubit<ReportBugState> {
  ReportBugCubit({required this.settingsRepo})
    : super(ReportBugInitialState());

  final SettingsRepo settingsRepo;

  Future<void> submitReport({required String problem}) async {
    emit(ReportBugLoadingState());

    final Either<Failure, Unit> result = await settingsRepo
        .submitReport(
          reportModel: ReportModel(
            problem: problem,
            userId: getUser().uid!,
          ),
        );

    result.fold(
      (failure) {
        emit(ReportBugFailureState(message: failure.message));
      },
      (_) {
        emit(ReportBugSuccessState());
      },
    );
  }
}
