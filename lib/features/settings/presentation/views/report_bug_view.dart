import '../../../../core/widgets/custom_app_bar_pop_icon.dart';
import '../widgets/report_bug_listener.dart';
import 'package:flutter/material.dart';

class ReportBugView extends StatelessWidget {
  const ReportBugView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إبلاغ عن خطأ"),
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
      ),
      body: const ReportBugListener(),
    );
  }
}
