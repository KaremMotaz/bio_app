import 'package:bio_app/core/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/functions/build_snack_bar.dart';
import '../../../../../core/routing/routes.dart';
import '../../manager/login_cubit/login_cubit.dart';
import 'login_view_body.dart';

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          final currentUser = FirebaseAuthService.currentUser!;
          final oldStudent = await BlocProvider.of<LoginCubit>(
            context,
          ).showUserIsOldOrNot();

          // Check if user logged in via Facebook (or other providers that don't require email verification)
          final isSocialLogin = currentUser.providerData.any(
            (userInfo) => userInfo.providerId != 'password',
          );

          if (!context.mounted) return;

          if (isSocialLogin || currentUser.emailVerified) {
            if (oldStudent == false) {
              successSnackBar(
                context: context,
                message: "تم تسجيل الدخول بنجاح.",
              );
              GoRouter.of(
                context,
              ).pushReplacement(Routes.fillProfileView);
            } else if (oldStudent == true) {
              GoRouter.of(context).pushReplacement(Routes.mainView);
              successSnackBar(
                context: context,
                message: "تم تسجيل الدخول بنجاح.",
              );
            }
          } else {
            errorSnackBar(
              context: context,
              message: "يرجى التحقق من بريدك الإلكتروني اولا.",
            );
          }
        }
        if (state is LoginFailureState) {
          errorSnackBar(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: Colors.white,
          ),
          inAsyncCall: state is LoginLoadingState ? true : false,
          child: const LoginViewBody(),
        );
      },
    );
  }
}
