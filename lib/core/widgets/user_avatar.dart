import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theming/app_colors.dart';

class UserAvatar extends StatelessWidget {
  final String name;
  final int savedColor;
  final String? imageUrl;
  final double? radius;
  final double? fontSize;
  const UserAvatar({
    super.key,
    required this.name,
    required this.savedColor,
    this.imageUrl,
    this.radius = 45,
    this.fontSize = 35,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null &&
        imageUrl!.isNotEmpty &&
        imageUrl != "null") {
      return CircleAvatar(
        backgroundColor: AppColors.lighterGray,
        radius: radius,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl!,
            fit: BoxFit.fill,
            width: radius! * 2,
            height: radius! * 2,
            errorWidget: (context, url, error) =>
                const Icon(Icons.error),
          ),
        ),
      );
    }
    final String initial = name.isNotEmpty
        ? name[0].toUpperCase()
        : "?";

    return CircleAvatar(
      radius: radius,
      backgroundColor: Color(savedColor),
      child: Text(
        initial,
        style: TextStyle(
          color: AppColors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
