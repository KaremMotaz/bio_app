import 'package:flutter/material.dart';

class ChaptersView extends StatelessWidget {
  const ChaptersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: Text('Chapters View'))],
        ),
      ),
    );
  }
}
