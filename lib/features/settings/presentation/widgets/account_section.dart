import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helpers/get_user.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/user_avatar.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("الحساب", style: TextStyles.bold20),
        const SizedBox(height: 20),
        ListTile(
          leading: UserAvatar(
            name: getUser().firstName!,
            savedColor: getUser().avatarColor!,
            imageUrl: getUser().imageUrl,
            fontSize: 24,
            radius: 24,
          ),
          title: Text(
            {getUser().firstName!, getUser().lastName!}.join(" "),
            style: TextStyles.bold18,
          ),
          subtitle: const Text("Student"),
          trailing: IconButton(
            onPressed: () {
              GoRouter.of(context).push(Routes.profileView);
            },
            icon: const Icon(Icons.chevron_right_rounded),
          ),
          onTap: () {
            GoRouter.of(context).push(Routes.profileView);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  }
}
