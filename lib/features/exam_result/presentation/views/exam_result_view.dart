import 'package:flutter/material.dart';

import 'widgets/exam_result_view_body.dart';

class ExamResultView extends StatelessWidget {
  const ExamResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Result"),
      ),
      body: ExamResultViewBody(),
    );
  }
}



