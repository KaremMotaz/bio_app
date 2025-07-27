import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';

import '../manager/reset_password_cubit/reset_password_cubit.dart';
import 'widgets/reset_password_view_body_bloc_consumer.dart';
import '../../../../core/services/get_it_service.dart';
import '../../domain/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (context) => ResetPasswordCubit(
        authRepo: getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "نسيت كلمة السر",
            style: TextStyles.bold18.copyWith(
              color: AppColors.mainBlue,
            ),
          ),
        ),
        body: const SafeArea(
          child: ResetPasswordViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
