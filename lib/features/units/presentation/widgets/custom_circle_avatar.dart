import '../../../../core/theming/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/get_user.dart';
import '../../../../core/widgets/user_avatar.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.2, 0.6],
              colors: [Color(0x992466F9), Color(0XFFEDEDED)],
            ),
          ),
        ),
        Container(
          width: 54,
          height: 54,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),

          child: UserAvatar(
            name: getUser().firstName!,
            savedColor: getUser().avatarColor!,
            fontSize: 28,
          ),
        ),
      ],
    );
  }
}
