import '../manager/login_cubit/login_cubit.dart';

import '../../../../core/services/get_it_service.dart';
import '../../domain/auth_repo.dart';
import 'widgets/signin_view_body_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(title: Text("تسجيل الدخول")),
        body: const SafeArea(child: LoginViewBodyBlocConsumer()),
      ),
    );
  }
}
