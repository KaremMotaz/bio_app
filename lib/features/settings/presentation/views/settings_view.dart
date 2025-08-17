import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../auth/domain/auth_repo.dart';
import '../../../auth/presentation/manager/log_out_cubit/log_out_cubit.dart';
import 'widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogOutCubit>(
      create: (context) =>
          LogOutCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "الإعدادات",
          ),
          centerTitle: true,
        ),
        body: const SafeArea(child: SettingsViewBody()),
      ),
    );
  }
}
