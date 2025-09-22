import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/features/settings/presentation/manager/review_app_cubit/review_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRating extends StatelessWidget {
  const CustomRating({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewAppCubit, ReviewAppState>(
      builder: (context, state) {
        return Row(
          children: [
            RatingBar.builder(
              initialRating: state.userRating,
              glow: false,
              minRating: 1,
              unratedColor: const Color(0xffffecb0),
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemPadding: const EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              itemBuilder: (context, _) {
                return SvgPicture.asset(
                  AssetsData.starIcon,
                  colorFilter: const ColorFilter.mode(
                    Color(0xfffec107),
                    BlendMode.srcIn,
                  ),
                );
              },
              onRatingUpdate: (value) {
                context.read<ReviewAppCubit>().setRating(
                  userRating: value,
                );
              },
            ),
            const SizedBox(width: 10),
            Text("(${state.userRating})"),
          ],
        );
      },
    );
  }
}
