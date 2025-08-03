import 'package:bio_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LessonsView extends StatelessWidget {
  const LessonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(Routes.quizView);
              },
              child: const Text("Go to Quiz"),
            ),
          ),
        ],
      ),
    );
  }
}
