import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import 'delete_account_dialog.dart';

Future<void> showPasswordDialog(
  BuildContext context,
  TextEditingController passwordController,
) async {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return BlocProvider.value(
          value: context.read<DeleteAccountCubit>(),
          child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
            builder: (context, state) {
              return deleteAccountDialog(
                context: ctx,
                textInputType: TextInputType.visiblePassword,
                title: "إدخال كلمة المرور الحالية",
                hintText: "إدخل كلمة المرور الحالية",
                controller: passwordController,
                isObscureText: state.isObscure,
                suffixIcon: IconButton(
                  onPressed: () {
                    context
                        .read<DeleteAccountCubit>()
                        .togglePasswordVisibility();
                  },
                  icon: Icon(
                    state.isObscure
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
            },
          ),
        );
      },
    );
  });
}
