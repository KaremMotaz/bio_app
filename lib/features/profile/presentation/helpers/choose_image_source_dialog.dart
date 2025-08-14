import 'package:bio_app/core/functions/build_snack_bar.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/app_text_button.dart';
import 'package:bio_app/features/profile/presentation/helpers/show_avatar_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void chooseImageSourceDialog({
  required BuildContext context,
  required Future<void> Function() pickImageFromGallery,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 20,
          ),
          width: 180,
          height: 220,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: AppColors.lighterGray,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.darkModeGray,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              AppTextButton(
                buttonText: "من الصور الرمزية",
                backgroundColor: AppColors.gray,
                textStyle: TextStyles.semiBold16.copyWith(
                  color: Colors.white,
                ),
                onPressed: () {
                  GoRouter.of(context).pop();
                  showAvatarsDialog(context: context);
                },
              ),
              const SizedBox(height: 20),
              AppTextButton(
                buttonText: "من المعرض",
                backgroundColor: AppColors.gray,
                textStyle: TextStyles.semiBold16.copyWith(
                  color: Colors.white,
                ),
                onPressed: () {
                  pickImageFromGallery;
                  if (context.mounted) {
                    successSnackBar(
                      context: context,
                      message: "تم اختيار الصورة بنجاح",
                    );
                    GoRouter.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
