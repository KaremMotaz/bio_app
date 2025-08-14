import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/get_it_service.dart';
import '../../../auth/domain/auth_repo.dart';
import '../../../auth/presentation/manager/fill_profile_cubit/fill_profile_cubit.dart';
import '../widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FillProfileCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("الملف الشخصي"),
          centerTitle: true,
        ),
        body: const ProfileViewBody(),
      ),
    );
  }
}
