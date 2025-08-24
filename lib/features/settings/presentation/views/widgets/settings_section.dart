import 'package:bio_app/core/functions/show_confirm_dialog.dart';
import 'package:bio_app/core/routing/routes.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/auth/presentation/manager/log_out_cubit/log_out_cubit.dart';
import 'package:bio_app/features/settings/presentation/views/widgets/custom_settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("الإعدادات", style: TextStyles.bold20),
        const SizedBox(height: 20),
        CustomSettingsListTile(
          bgIconcolor: const Color(0xfffee9f0),
          title: "تسجيل الخروج",
          onTap: () {
            showConfirmDialog(
              context: context,
              buttonText: "خروج",
              bodyContent:
                  "هل أنت متأكد أنك تريد تسجيل الخروج؟",
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
        CustomSettingsListTile(
          bgIconcolor: const Color(0xfffee9f0),
          title: "حذف الحساب",
          onTap: () {
            showConfirmDialog(
              context: context,
              buttonText: "حذف",
              bodyContent: "هل أنت متأكد أنك تريد حذف حسابك؟",
              title: "حذف الحساب؟",
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
          icon: Icons.delete_forever_rounded,
          iconcolor: const Color(0xffd05b75),
        ),
      ],
    );
  }
}
