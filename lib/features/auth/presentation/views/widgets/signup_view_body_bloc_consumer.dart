import '../../../../../core/functions/build_snack_bar.dart';
import '../../../../../core/routing/routes.dart';
import '../../manager/signup_cubit/signup_cubit.dart';
import 'signup_view_body.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          successSnackBar(context: context, message: "تم إنشاء حسابك بنجاح.");
          GoRouter.of(context).pushReplacement(Routes.otpVerificationView);
        }
        if (state is SignupFailureState) {
          errorSnackBar(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoadingState ? true : false,
          child: const SignupViewBody(),
        );
      },
    );
  }
}
