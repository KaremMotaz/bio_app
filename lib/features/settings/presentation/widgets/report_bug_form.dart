import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/app_text_form_field.dart';
import 'package:bio_app/core/widgets/bloc_button.dart';
import 'package:bio_app/features/settings/presentation/manager/report_bug_cubit/report_bug_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportBugForm extends StatefulWidget {
  const ReportBugForm({super.key});

  @override
  State<ReportBugForm> createState() => _ReportBugFormState();
}

class _ReportBugFormState extends State<ReportBugForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController problemController =
      TextEditingController();

  @override
  void dispose() {
    problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(AssetsData.bugImage, height: 150),
          ),
          const Text("أكتب الخطأ", style: TextStyles.bold18),
          const SizedBox(height: 16),
          AppTextFormField(
            hintText: "أخبرنا عن الخطأ",
            minLines: 7,
            controller: problemController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "يرجى كتابة الخطأ";
              }
              return null;
            },
          ),
          const SizedBox(height: 35),
          BlocButton<ReportBugCubit, ReportBugState>(
            label: "إبلاغ",
            isLoading: (state) => state is ReportBugLoadingState,
            onPressed: () {
              validateThenSubmitReport(context);
            },
          ),
        ],
      ),
    );
  }

  void validateThenSubmitReport(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<ReportBugCubit>().submitReport(
        problem: problemController.text,
      );
    }
  }
}
