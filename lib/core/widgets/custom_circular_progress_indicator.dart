import '../theming/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 21,
        height: 21,
        child: CircularProgressIndicator(
          color: color ?? AppColors.white,
        ),
      ),
    );
  }
}
