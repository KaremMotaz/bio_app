// import 'package:bio_app/features/home/presentation/views/widgets/custom_list_item.dart';
import 'package:bio_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
