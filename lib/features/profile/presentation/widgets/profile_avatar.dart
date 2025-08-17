import '../../../../core/functions/build_snack_bar.dart';
import '../../../../core/helpers/get_user.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../helpers/choose_image_source_dialog.dart';
import '../manager/change_profile_image_cubit/change_profile_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
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
          errorSnackBar(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return state is ChangeProfileImageLoadingState
            ? const CircleAvatar(
                radius: 45,
                backgroundColor: AppColors.lighterGray,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                ),
              )
            : Stack(
                children: [
                  UserAvatar(
                    name: getUser().firstName!,
                    imageUrl: getUser().imageUrl,
                    savedColor: getUser().avatarColor!,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        chooseImageSourceDialog(
                          parentContext: context,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
