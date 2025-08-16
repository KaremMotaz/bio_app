import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/app_text_button.dart';
import 'package:bio_app/core/widgets/close_icon.dart';
import 'package:bio_app/features/profile/presentation/helpers/show_avatar_dialog.dart';
import 'package:bio_app/features/profile/presentation/manager/change_profile_image_cubit/change_profile_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void chooseImageSourceDialog({required BuildContext parentContext}) {
  final cubit = parentContext.read<ChangeProfileImageCubit>();
  showDialog(
    context: parentContext,
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: Dialog(
          child: Container(
            height: 210,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: AppColors.lighterGray,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                const CloseIcon(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      AppTextButton(
                        buttonText: "من الصور الرمزية",
                        backgroundColor: Colors.grey,
                        textStyle: TextStyles.semiBold16.copyWith(
                          color: Colors.white,
                        ),
                        onPressed: () {
                          GoRouter.of(context).pop();
                          showAvatarsDialog(context: parentContext);
                        },
                      ),
                      const SizedBox(height: 20),
                      AppTextButton(
                        buttonText: "من المعرض",
                        backgroundColor: Colors.grey,
                        textStyle: TextStyles.semiBold16.copyWith(
                          color: Colors.white,
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
      );
    },
  );
}
