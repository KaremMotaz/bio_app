import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/functions/show_confirm_dialog.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/assets_data.dart';
import '../../../auth/presentation/manager/log_out_cubit/log_out_cubit.dart';
import 'custom_settings_list_tile.dart';

class LogoutListTile extends StatelessWidget {
  const LogoutListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSettingsListTile(
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
            GoRouter.of(context).pushReplacement(Routes.signInView);
          },
        );
      },
      trailing: const SizedBox.shrink(),
      icon: AssetsData.logoutIcon,
      iconcolor:  AppColors.red,
    );
  }
}
