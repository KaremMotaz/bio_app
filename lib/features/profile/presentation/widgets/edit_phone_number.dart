import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/get_user.dart';
import '../../../../core/theming/assets_data.dart';
import '../manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'edit_profile_dialog.dart';
import '../../../settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPhoneNumber extends StatelessWidget {
  const EditPhoneNumber({
    super.key,
    required this.phoneNumberController,
  });

  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      title: "الهاتف",
      subTitle: Text(getUser().phoneNumber ?? ""),
      onTap: () {
        editProfileDialog(
          context: context,
          textInputType: TextInputType.phone,
          title: "تعديل رقم الهاتف",
          hintText: "أدخل رقم الهاتف",
          controller: phoneNumberController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              phoneNumberController.clear();
              return "يرجي أدخال رقم الهاتف";
            } else if (!AppRegex.isPhoneNumberValid(value)) {
              return "رقم الهاتف غير صالح";
            }
            return null;
          },
          onPressed: () {
            context.read<EditProfileCubit>().updatePhoneNumber(
              newPhoneNumber: phoneNumberController.text,
            );
          },
        );
      },
      icon: AssetsData.phoneIcon,
      isTrailingIcon: true,
    );
  }
}
