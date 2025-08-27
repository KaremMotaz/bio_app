import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_bar_pop_icon.dart';
import '../../domain/auth_repo.dart';
import '../manager/reset_password_cubit/reset_password_cubit.dart';
import 'widgets/reset_password_view_body_bloc_consumer.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (context) =>
          ResetPasswordCubit(authRepo: getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "نسيت كلمة السر",
            style: TextStyles.bold18.copyWith(
              color: AppColors.mainBlue,
            ),
          ),
          leading: Navigator.of(context).canPop()
              ? const CustomAppBarPopIcon()
              : null,
        ),
        body: const SafeArea(
          child: ResetPasswordViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
