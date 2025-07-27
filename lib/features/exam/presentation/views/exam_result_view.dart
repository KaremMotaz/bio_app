import 'package:flutter/material.dart';

class ExamResultView extends StatelessWidget {
  const ExamResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: Center(
        child: Text("Result"),
      ),
    );
  }
}

