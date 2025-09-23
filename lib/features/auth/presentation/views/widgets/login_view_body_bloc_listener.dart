import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/functions/build_snack_bar.dart';
import '../../manager/login_cubit/login_cubit.dart';
import 'login_view_body.dart';

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginNavigateState) {
          successSnackBar(context: context, message: state.message);
          GoRouter.of(context).pushReplacement(state.route);
        }
        if (state is LoginFailureState) {
          errorSnackBar(context: context, message: state.message);
        }
      },
      child: const LoginViewBody(),
    );
  }
}
