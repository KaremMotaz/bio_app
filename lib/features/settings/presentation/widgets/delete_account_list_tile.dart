import 'package:bio_app/core/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/functions/build_snack_bar.dart';
import '../../../../core/functions/show_confirm_dialog.dart';
import '../../../../core/routing/routes.dart';
import '../../../auth/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import '../helpers/show_password_dialog.dart';
import 'custom_settings_list_tile.dart';

class DeleteAccountListTile extends StatefulWidget {
  const DeleteAccountListTile({super.key});

  @override
  State<DeleteAccountListTile> createState() =>
      _DeleteAccountListTileState();
}

class _DeleteAccountListTileState
    extends State<DeleteAccountListTile> {
  final TextEditingController passwordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccessState) {
          GoRouter.of(context).pop();
          successSnackBar(
            context: context,
            message: "تم حذف الحساب الشخصي بنجاح",
          );
          GoRouter.of(context).pushReplacement(Routes.signInView);
        } else if (state is DeleteAccountFailureState) {
          GoRouter.of(context).pop();
          errorSnackBar(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        return CustomSettingsListTile(
          bgIconcolor: const Color(0xfffee9f0),
          title: "حذف الحساب",
          onTap: () {
            showConfirmDialog(
              context: context,
              buttonText: "حذف",
              bodyContent: "هل أنت متأكد أنك تريد حذف حسابك؟",
              title: "حذف الحساب؟",
              buttonColor: const Color(0xffdb2323),
              onPressed: () async {
                final user = FirebaseAuthService.currentUser;
                if (user == null) return;

                final provider = user.providerData.first.providerId;

                if (provider == 'password') {
                  return showPasswordDialog(
                    context,
                    passwordController,
                  );
                } else {
                  await context
                      .read<DeleteAccountCubit>()
                      .deleteAccount();
                }
              },
            );
          },
          trailing: const SizedBox.shrink(),
          icon: Icons.delete_forever_rounded,
          iconcolor: const Color(0xffd05b75),
        );
      },
    );
  }
}
