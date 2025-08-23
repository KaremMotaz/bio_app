import 'package:flutter/material.dart';

class CustomAppBarPopIcon extends StatelessWidget {
  const CustomAppBarPopIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
        size: 18,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
