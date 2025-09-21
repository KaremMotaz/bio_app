import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/close_icon.dart';
import '../manager/change_profile_image_cubit/change_profile_image_cubit.dart';
import 'show_avatar_dialog.dart';

void chooseImageSourceDialog({required BuildContext parentContext}) {
  final cubit = parentContext.read<ChangeProfileImageCubit>();
  showDialog(
    context: parentContext,
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: Dialog(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: AppColors.lighterGray,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CloseIcon(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        AppTextButton(
                          buttonText: "من الصور الرمزية",
                          backgroundColor: AppColors.grey,
                          textStyle: TextStyles.semiBold16.copyWith(
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            GoRouter.of(context).pop();
                            showAvatarsDialog(context: parentContext);
                          },
                        ),
                        const SizedBox(height: 20),
                        AppTextButton(
                          buttonText: "من المعرض",
                          backgroundColor: AppColors.grey,
                          textStyle: TextStyles.semiBold16.copyWith(
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            cubit.changeProfileImageFromGallery();
                            GoRouter.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
