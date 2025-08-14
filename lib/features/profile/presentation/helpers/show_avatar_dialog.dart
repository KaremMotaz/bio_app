import 'package:bio_app/core/functions/build_snack_bar.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/core/widgets/app_text_button.dart';
import 'package:bio_app/features/profile/presentation/manager/cubit/change_profile_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void showAvatarsDialog({required BuildContext context}) {
  List<String> avatarPaths = List.generate(8, (index) {
    return "assets/avatars/avatar${index + 1}.png";
  });

  int? selectedIndex; // Store the selected avatar index

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
            top: 8,
            bottom: 24,
          ),
          child: SizedBox(
            width: 400,
            height: 310,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
                const Text(
                  "اختار الافاتار المناسب",
                  style: TextStyles.bold18,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                        itemBuilder: (context, index) {
                          bool isSelected = selectedIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: isSelected
                                  ? AppColors.mainBlue
                                  : Colors.white,
                              child: CircleAvatar(
                                radius: 27,
                                backgroundImage: AssetImage(
                                  avatarPaths[index],
                                ),
                                backgroundColor: Theme.of(
                                  context,
                                ).cardColor,
                              ),
                            ),
                          );
                        },
                        itemCount: 8,
                      );
                    },
                  ),
                ),
                AppTextButton(
                  buttonText: "تأكيد",
                  backgroundColor: AppColors.mainBlue,
                  textStyle: TextStyles.semiBold16.copyWith(
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (selectedIndex != null) {
                      context
                          .read<ChangeProfileImageCubit>()
                          .selectImage(
                            image: null,
                            avatarPath: avatarPaths[selectedIndex!],
                          );

                      successSnackBar(
                        context: context,
                        message: "تم اختيار الافاتار بنجاح",
                      );
                      GoRouter.of(context).pop();
                    } else {
                      errorSnackBar(
                        context: context,
                        message: "من فضلك اختار افاتار",
                      );
                      GoRouter.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
