import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bio_app/core/routing/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          GoRouter.of(context).push(Routes.quizView);
        },
        child: Text("Go to Quiz"),
      ),
    );
  }
}
