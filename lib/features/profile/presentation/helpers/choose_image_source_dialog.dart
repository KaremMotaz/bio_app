import 'package:bio_app/core/functions/build_snack_bar.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/app_text_button.dart';
import 'package:bio_app/core/widgets/close_icon.dart';
import 'package:bio_app/features/profile/presentation/helpers/show_avatar_dialog.dart';
import 'package:bio_app/features/profile/presentation/manager/cubit/change_profile_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void chooseImageSourceDialog({required BuildContext context}) {
  final cubit = context.read<ChangeProfileImageCubit>();
  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child:
            BlocListener<
              ChangeProfileImageCubit,
              ChangeProfileImageState
            >(
              listener: (context, state) {
                if (state is ChangeProfileImageSuccessState) {
                  successSnackBar(
                    context: context,
                    message: "تم تغيير الصورة بنجاح",
                  );
                } else if (state is ChangeProfileImageErrorState) {
                  errorSnackBar(
                    context: context,
                    message: state.error,
                  );
                }
              },
              child: Dialog(
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20,
                  ),
                  width: 180,
                  height: 220,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: AppColors.lighterGray,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CloseIcon(),
                      const SizedBox(height: 10),
                      AppTextButton(
                        buttonText: "من الصور الرمزية",
                        backgroundColor: AppColors.gray,
                        textStyle: TextStyles.semiBold16.copyWith(
                          color: Colors.white,
                        ),
                        onPressed: () {
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
                          cubit.changeProfileImageFromGallery();
                          GoRouter.of(context).pop();
                        },
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
