import 'package:bio_app/core/functions/build_snack_bar.dart';
import 'package:bio_app/core/functions/show_confirm_dialog.dart';
import 'package:bio_app/core/routing/routes.dart';
import 'package:bio_app/features/auth/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:bio_app/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:bio_app/features/settings/presentation/views/widgets/custom_settings_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountListTile extends StatefulWidget {
  const DeleteAccountListTile({super.key});

  @override
  State<DeleteAccountListTile> createState() =>
      _DeleteAccountListTileState();
}

class _DeleteAccountListTileState
    extends State<DeleteAccountListTile> {
  bool isPasswordObscureText = true;

  final TextEditingController passwordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordObscureText = !isPasswordObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccessState) {
          successSnackBar(
            context: context,
            message: "تم حذف الحساب الشخصي بنجاح",
          );
          GoRouter.of(context).pushReplacement(Routes.signInView);
        } else if (state is DeleteAccountFailureState) {
          errorSnackBar(context: context, message: state.message);
          GoRouter.of(context).pop();
        }
      },
      child: CustomSettingsListTile(
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
              final user = FirebaseAuth.instance.currentUser;
              if (user == null) return;

              final provider = user.providerData.first.providerId;

              if (provider == 'password') {
                return customDialog(
                  context: context,
                  textInputType: TextInputType.visiblePassword,
                  title: "إدخال كلمة المرور الحالية",
                  hintText: "إدخل كلمة المرور الحالبة",
                  controller: passwordController,
                  isObscureText: isPasswordObscureText,
                  suffixIcon: IconButton(
                    onPressed: () {
                      togglePasswordVisibility();
                    },
                    icon: Icon(
                      isPasswordObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجي أدخال كلمة المرور";
                    }
                    return null;
                  },
                  onPressed: () async {
                    await context
                        .read<DeleteAccountCubit>()
                        .deleteAccount(
                          password: passwordController.text,
                        );
                    passwordController.clear();
                  },
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
      ),
    );
  }
}
