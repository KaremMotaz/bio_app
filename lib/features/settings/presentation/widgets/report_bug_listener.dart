import '../../../../core/functions/build_snack_bar.dart';
import '../manager/report_bug_cubit/report_bug_cubit.dart';
import 'add_bug_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReportBugListener extends StatelessWidget {
  const ReportBugListener({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener<ReportBugCubit, ReportBugState>(
        listener: (context, state) {
          if (state is ReportBugSuccessState) {
            successSnackBar(
              context: context,
              message: "Thanks for your Time",
            );
            GoRouter.of(context).pop();
          }
          if (state is ReportBugFailureState) {
            errorSnackBar(context: context, message: state.message);
          }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [AddBugReport()]),
        ),
      ),
    );
  }
}
