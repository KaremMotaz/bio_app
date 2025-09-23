import '../../../../core/theming/assets_data.dart';
import '../manager/app_rating_cubit/app_rating_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRating extends StatelessWidget {
  const CustomRating({
    super.key,
    required this.isEditable,
    required this.userRating,
  });
  final bool isEditable;
  final double? userRating;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEditable,
      child: Column(
        children: [
          RatingBar.builder(
            initialRating: userRating ?? 0,
            updateOnDrag: isEditable,
            glow: false,
            minRating: 1,
            unratedColor: const Color(0xffffecb0),
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 40,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) {
              return SvgPicture.asset(AssetsData.starIcon);
            },
            onRatingUpdate: (value) {
              if (isEditable) {
                context.read<AppRatingCubit>().setUserRating(
                  userRating: value,
                );
              }
            },
          ),
          const SizedBox(height: 10),
          Text("(${userRating ?? 0})"),
        ],
      ),
    );
  }
}
