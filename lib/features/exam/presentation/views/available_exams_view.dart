import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';

class AvailableExamsView extends StatelessWidget {
  const AvailableExamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Available Exams"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () {
                GoRouter.of(context).push(Routes.examView);
              },
              child: Text(
                "Go to Exam",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.mainBlue,
              ),
              onPressed: () {
                GoRouter.of(context).push(Routes.examResultView);
              },
              child: Text(
                "Go to Exam Result",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
