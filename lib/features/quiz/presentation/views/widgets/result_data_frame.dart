import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bio_app/core/theming/text_styles.dart';

class ResultDataFrame extends StatelessWidget {
  const ResultDataFrame({
    super.key,
    required this.color,
    required this.data,
    required this.icon,
    required this.title,
  });

  final Color color;
  final String data;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: -28,
          child: Container(
            width: 102,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyles.extraBold12.copyWith(color: Colors.white),
            ),
          ),
        ),
        Container(
          width: 102,
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            border: Border.all(color: color, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon, height: 30),
              const SizedBox(width: 7),
              Text(data, style: TextStyles.extraBold21.copyWith(color: color)),
            ],
          ),
        ),
      ],
    );
  }
}
