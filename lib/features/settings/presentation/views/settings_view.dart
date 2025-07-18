import 'package:bio_app/core/services/get_it_service.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/auth/domain/auth_repo.dart';
import 'package:bio_app/features/auth/presentation/manager/log_out_cubit/log_out_cubit.dart';
import 'package:bio_app/features/settings/presentation/views/widgets/settings_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          title: Text(
            "Settings",
            style: TextStyles.medium16,
          ),
          centerTitle: true,
        ),
        body: const SafeArea(child: SettingsViewBody()),
      ),
    );
  }
}
