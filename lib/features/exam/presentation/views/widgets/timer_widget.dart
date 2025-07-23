import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final Duration duration;

  const TimerWidget({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.timer),
          const SizedBox(width: 8),
          Text('Time: ${duration.inMinutes} minutes'),
        ],
      ),
    );
  }
}
