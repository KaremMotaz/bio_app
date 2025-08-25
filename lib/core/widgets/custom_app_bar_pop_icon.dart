import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBarPopIcon extends StatelessWidget {
  const CustomAppBarPopIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: Colors.grey.shade600,
        size: 18,
      ),
      onPressed: () => GoRouter.of(context).pop(),
    );
  }
}
