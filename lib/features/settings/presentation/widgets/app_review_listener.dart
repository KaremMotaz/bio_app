import 'package:bio_app/core/functions/build_snack_bar.dart';
import 'package:bio_app/features/settings/presentation/manager/review_app_cubit/review_app_cubit.dart';
import 'package:bio_app/features/settings/presentation/widgets/add_app_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppReviewListener extends StatelessWidget {
  const AppReviewListener({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener<ReviewAppCubit, ReviewAppState>(
        listener: (context, state) {
          if (state is ReviewAppSuccessState) {
            successSnackBar(
              context: context,
              message: "Thanks for your Review",
            );
            GoRouter.of(context).pop();
          }
          if (state is ReviewAppFailureState) {
            errorSnackBar(context: context, message: state.message);
          }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [AddAppReview()]),
        ),
      ),
    );
  }
}
