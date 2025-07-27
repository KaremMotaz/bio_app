import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/functions/build_snack_bar.dart';
import '../../manager/reset_password_cubit/reset_password_cubit.dart';
import 'reset_password_view_body.dart';

class ResetPasswordViewBodyBlocConsumer extends StatelessWidget {
  const ResetPasswordViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          GoRouter.of(context).pop();
        }
        if (state is ResetPasswordFailureState) {
          errorSnackBar(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ResetPasswordLoadingState ? true : false,
          child: const ResetPasswordViewBody(),
        );
      },
    );
  }
}
