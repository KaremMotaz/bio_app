import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/app_text_form_field.dart';
import 'package:bio_app/core/widgets/bloc_button.dart';
import 'package:bio_app/features/settings/presentation/manager/review_app_cubit/review_app_cubit.dart';
import 'package:bio_app/features/settings/presentation/widgets/custom_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppReviewForm extends StatefulWidget {
  const AppReviewForm({super.key});

  @override
  State<AppReviewForm> createState() => _AppReviewFormState();
}

class _AppReviewFormState extends State<AppReviewForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reviewController =
      TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("أضف تقييمك", style: TextStyles.bold18),
          const SizedBox(height: 16),
          const CustomRating(),
          const SizedBox(height: 20),
          AppTextFormField(
            hintText: "أخبرنا عن تقييمك",
            minLines: 7,
            controller: reviewController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "يرجى كتابة تقييمك";
              }
              return null;
            },
          ),
          const SizedBox(height: 35),
          BlocButton<ReviewAppCubit, ReviewAppState>(
            label: "إرسال",
            isLoading: (state) => state is ReviewAppLoadingState,
            onPressed: () {
              validateThenSubmitReview(context);
            },
          ),
        ],
      ),
    );
  }

  void validateThenSubmitReview(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<ReviewAppCubit>().submitReview(
        content: reviewController.text,
      );
    }
  }
}
