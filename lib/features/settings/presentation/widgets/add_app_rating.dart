import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/bloc_button.dart';
import '../manager/app_rating_cubit/app_rating_cubit.dart';
import 'app_rating_background.dart';
import 'custom_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAppRating extends StatelessWidget {
  const AddAppRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppRatingBackground(),
        Transform.translate(
          offset: const Offset(0, -16),
          child: const Text("أضف تقييمك", style: TextStyles.bold18),
        ),
        const SizedBox(height: 16),
        BlocBuilder<AppRatingCubit, AppRatingState>(
          builder: (context, state) {
            return CustomRating(
              isEditable: true,
              userRating: state.userRating ?? 0,
            );
          },
        ),
        const SizedBox(height: 35),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: BlocButton<AppRatingCubit, AppRatingState>(
            borderRadius: 30,
            label: "تقييم",
            isLoading: (state) => state is AppRatingLoadingState,
            onPressed: () {
              context.read<AppRatingCubit>().submitAppRating();
            },
          ),
        ),
        const SizedBox(height: 35),
      ],
    );
  }
}
