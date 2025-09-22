import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRating extends StatefulWidget {
  const CustomRating({super.key});

  @override
  State<CustomRating> createState() => _CustomRatingState();
}

class _CustomRatingState extends State<CustomRating> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: 0,
          glow: false,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) {
            return SvgPicture.asset(
              AssetsData.starIcon,
              colorFilter: const ColorFilter.mode(
                AppColors.amber,
                BlendMode.srcIn,
              ),
            );
          },
          onRatingUpdate: (value) {
            setState(() {
              rating = value;
            });
          },
        ),
        const SizedBox(width: 10),
        Text("($rating)"),
      ],
    );
  }
}
