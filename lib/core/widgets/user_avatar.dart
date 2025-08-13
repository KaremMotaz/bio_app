import 'package:flutter/material.dart';

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
    if (imageUrl != null && imageUrl!.isNotEmpty && imageUrl != "null") {
      return CircleAvatar(
        backgroundImage: NetworkImage(imageUrl!),
        radius: radius,
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
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
