import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/assets_data.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/bloc_button.dart';
import '../helpers/rating_message.dart';
import '../manager/app_rating_cubit/app_rating_cubit.dart';
import 'app_rating_background.dart';
import 'custom_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class EditAppRating extends StatelessWidget {
  const EditAppRating({super.key, required this.userRating});
  final double userRating;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            const AppRatingBackground(),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                AssetsData.circle,
                height: 80,
                width: 80,
              ),
            ),
            Positioned(
              top: 22,
              right: 0,
              left: 0,
              child: Image.asset(
                userRating.ratingEmojiAsset,
                height: 75,
                width: 75,
              ),
            ),
          ],
        ),
        Transform.translate(
          offset: const Offset(0, -16),
          child: const Text("شكرا", style: TextStyles.semiBold24),
        ),
        Text(
          userRating.ratingFeedback,
          style: TextStyles.regular16,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        BlocBuilder<AppRatingCubit, AppRatingState>(
          builder: (context, state) {
            return CustomRating(
              isEditable: false,
              userRating: state.userRating,
            );
          },
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: BlocButton<AppRatingCubit, AppRatingState>(
            borderRadius: 30,
            label: "تعديل التقييم",
            isLoading: (state) => state is AppRatingLoadingState,
            onPressed: () {
              context.read<AppRatingCubit>().resetRating();
            },
          ),
        ),

        TextButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: Text(
            "رجوع",
            style: TextStyles.bold18.copyWith(
              color: AppColors.grey600,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
