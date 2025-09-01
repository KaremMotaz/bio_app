import '../../../../../core/services/firebase_auth_service.dart';
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
          try {
            
            await FirebaseAuthService.currentUser?.reload();
            final currentUser = FirebaseAuthService.currentUser;

            if (currentUser == null) {
              if (!context.mounted) return;
              errorSnackBar(
                context: context,
                message:
                    "لم يتم العثور على بيانات المستخدم. حاول مرة أخرى.",
              );
              return;
            }

          
            if (!context.mounted) return;

          
            final oldStudent = await context
                .read<LoginCubit>()
                .showUserIsOldOrNot();

            // حاول تحقق من حسابك هل يكون مسجل بواسطة حساب جوجل او فيسبوك
            final isSocialLogin = currentUser.providerData.any(
              (userInfo) => userInfo.providerId != 'password',
            );

            if (!context.mounted) return;

            if (isSocialLogin || currentUser.emailVerified) {
              if (!oldStudent) {
                successSnackBar(
                  context: context,
                  message: "تم تسجيل الدخول بنجاح.",
                );
                GoRouter.of(
                  context,
                ).pushReplacement(Routes.fillProfileView);
              } else {
                successSnackBar(
                  context: context,
                  message: "تم تسجيل الدخول بنجاح.",
                );
                GoRouter.of(context).pushReplacement(Routes.mainView);
              }
            } else {
              errorSnackBar(
                context: context,
                message: "يرجى التحقق من بريدك الإلكتروني أولاً.",
              );
            }
          } catch (e) {
          
            errorSnackBar(
              context: context,
              message:
                  "تعذر إكمال تسجيل الدخول. تأكد من اتصالك بالإنترنت.",
            );
            debugPrint("Login flow error: $e");
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
          inAsyncCall: state is LoginLoadingState,
          child: const LoginViewBody(),
        );
      },
    );
  }
}
