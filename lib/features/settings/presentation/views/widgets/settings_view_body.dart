import '../../../../../core/helpers/get_user.dart';
import '../../../../../core/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/functions/show_confirm_dialog.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../auth/presentation/manager/log_out_cubit/log_out_cubit.dart';
import 'custom_settings_list_tile.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
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
            const SizedBox(height: 30),
            const Text("الإعدادات", style: TextStyles.bold20),
            const SizedBox(height: 20),
            CustomSettingsListTile(
              bgIconcolor: const Color(0xfffee9f0),
              title: "تسجيل الخروج",
              onTap: () {
                showConfirmDialog(
                  context: context,
                  buttonText: "خروج",
                  bodyContent: "هل أنت متأكد أنك تريد تسجيل الخروج؟",
                  title: "تسجيل الخروج؟",
                  buttonColor: const Color(0xffdb2323),
                  onPressed: () async {
                    await context.read<LogOutCubit>().logOut();
                    if (!context.mounted) return;
                    GoRouter.of(
                      context,
                    ).pushReplacement(Routes.signInView);
                  },
                );
              },
              trailing: const SizedBox.shrink(),
              icon: Icons.logout_rounded,
              iconcolor: const Color(0xffd05b75),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
