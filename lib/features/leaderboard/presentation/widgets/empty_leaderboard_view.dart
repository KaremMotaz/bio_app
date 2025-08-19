import 'package:flutter/material.dart';

class EmptyLeaderboardView extends StatelessWidget {
  const EmptyLeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "لا يوجد متصدرين بعد 👑",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
