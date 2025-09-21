import 'package:bio_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../auth/domain/auth_repo.dart';
import '../../../auth/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import '../../../auth/presentation/manager/log_out_cubit/log_out_cubit.dart';
import '../widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LogOutCubit>(
          create: (context) =>
              LogOutCubit(authRepo: getIt.get<AuthRepo>()),
        ),
        BlocProvider<DeleteAccountCubit>(
          create: (context) =>
              DeleteAccountCubit(authRepo: getIt.get<AuthRepo>()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text("الإعدادات"),
          centerTitle: true,
        ),
        body: const SafeArea(child: SettingsViewBody()),
      ),
    );
  }
}
