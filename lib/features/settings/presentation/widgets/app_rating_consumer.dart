import '../../../../core/functions/build_snack_bar.dart';
import '../manager/app_rating_cubit/app_rating_cubit.dart';
import 'add_app_rating.dart';
import 'edit_app_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRatingConsumer extends StatelessWidget {
  const AppRatingConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<AppRatingCubit, AppRatingState>(
        listener: (context, state) {
          if (state is AppRatingFailureState) {
            errorSnackBar(context: context, message: state.message);
            GoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is AppRatingNotRatedState ||
              state is AppRatingInitialState) {
            return const AddAppRating();
          }

          if (state is AppRatingRatedState) {
            return EditAppRating(userRating: state.userRating ?? 0);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
