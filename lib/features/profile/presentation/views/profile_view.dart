import 'package:bio_app/core/services/get_it_service.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:bio_app/features/auth/domain/auth_repo.dart';
import 'package:bio_app/features/auth/presentation/manager/fill_profile_cubit/fill_profile_cubit.dart';
import 'package:bio_app/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FillProfileCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "الملف الشخصي",
            style: TextStyles.bold18,
          ),
          centerTitle: true,
        ),
        body: const ProfileViewBody(),
      ),
    );
  }
}