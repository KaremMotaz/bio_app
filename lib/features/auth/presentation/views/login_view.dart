import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../../core/widgets/custom_app_bar_pop_icon.dart';
import '../../domain/auth_repo.dart';
import '../manager/login_cubit/login_cubit.dart';
import 'widgets/login_view_body_bloc_consumer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تسجيل الدخول"),
          leading: Navigator.of(context).canPop()
              ? const CustomAppBarPopIcon()
              : null,
        ),
        body: const SafeArea(child: LoginViewBodyBlocConsumer()),
      ),
    );
  }
}
