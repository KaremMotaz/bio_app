import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/functions/build_snack_bar.dart';
import '../../../../../core/routing/routes.dart';
import '../../manager/fill_profile_cubit/fill_profile_cubit.dart';
import 'fill_profile_view_body.dart';

class FillProfileViewBodyBlocConsumer extends StatelessWidget {
  const FillProfileViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FillProfileCubit, FillProfileState>(
      listener: (context, state) {
        if (state is FillProfileSuccessState) {
          successSnackBar(
            context: context,
            message: "تم تحديث الملف الشخصي بنجاح",
          );
          GoRouter.of(context).pushReplacement(Routes.mainView);
        } else if (state is FillProfileFailureState) {
          errorSnackBar(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        return const FillProfileViewBody();
      },
    );
  }
}
