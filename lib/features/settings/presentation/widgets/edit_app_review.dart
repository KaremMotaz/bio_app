import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/bloc_button.dart';
import 'package:bio_app/core/widgets/close_icon.dart';
import 'package:bio_app/features/settings/presentation/manager/review_app_cubit/review_app_cubit.dart';
import 'package:bio_app/features/settings/presentation/widgets/custom_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class EditAppReview extends StatelessWidget {
  const EditAppReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Transform.translate(
              offset: const Offset(0, -26),
              child: SvgPicture.asset(AssetsData.reviewBackground),
            ),
            const CloseIcon(color: AppColors.white),
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
                AssetsData.smilingFaceWithHeartEyes,
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
        const Text(
          "سنعمل بجهد أكبر لنجعلك أكثر رضا.",
          style: TextStyles.regular16,
        ),
        const SizedBox(height: 16),
        const CustomRating(),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: BlocButton<ReviewAppCubit, ReviewAppState>(
            borderRadius: 30,
            label: "تعديل التقييم",
            isLoading: (state) => state is ReviewAppLoadingState,
            onPressed: () {
              context.read<ReviewAppCubit>().submitReview();
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
