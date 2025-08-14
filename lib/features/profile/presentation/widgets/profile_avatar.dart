import 'package:bio_app/core/helpers/get_user.dart';
import 'package:bio_app/core/widgets/user_avatar.dart';
import 'package:bio_app/features/profile/presentation/helpers/choose_image_source_dialog.dart';
import 'package:bio_app/features/profile/presentation/manager/cubit/change_profile_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ChangeProfileImageCubit,
      ChangeProfileImageState
    >(
      builder: (context, state) {
        return Stack(
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
                    context: context,
                    pickImageFromGallery: () {
                      return context
                          .read<ChangeProfileImageCubit>()
                          .selectImageFromGallery();
                    },
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
