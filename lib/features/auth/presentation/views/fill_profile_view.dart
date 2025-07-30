import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../domain/auth_repo.dart';
import '../manager/fill_profile_cubit/fill_profile_cubit.dart';
import 'widgets/fill_profile_view_body_bloc_consumer.dart';

class FillProfileView extends StatelessWidget {
  const FillProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FillProfileCubit>(
      create: (context) => FillProfileCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("تعبئة الملف الشخصي")),
        body: const SafeArea(
          child: FillProfileViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
