import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/get_it_service.dart';
import '../../domain/auth_repo.dart';
import '../manager/signup_cubit/signup_cubit.dart';
import 'widgets/signup_view_body_bloc_consumer.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(
      create: (context) =>
          SignupCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "إنشاء حساب جديد",
            style: TextStyles.bold18.copyWith(
              color: AppColors.mainBlue,
            ),
          ),
        ),
        body: const SafeArea(
          child: SignupViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
