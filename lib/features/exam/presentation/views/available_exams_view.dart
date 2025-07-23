import 'package:bio_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
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
          ),
        ],
      ),
    );
  }
}
