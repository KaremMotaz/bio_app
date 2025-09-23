import '../../../../core/helpers/get_user.dart';
import '../../../../core/theming/assets_data.dart';
import '../manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'edit_profile_dialog.dart';
import '../../../settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditLastName extends StatelessWidget {
  const EditLastName({super.key, required this.lastNameController});

  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      title: "الأسم الأخير",
      subTitle: Text(getUser().lastName ?? ""),
      onTap: () {
        editProfileDialog(
          context: context,
          textInputType: TextInputType.name,
          title: "تعديل الأسم الأخير",
          hintText: "أدخل الأسم الأخير",
          controller: lastNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "يرجي أدخال الأسم الأخير";
            }
            return null;
          },
          onPressed: () {
            context.read<EditProfileCubit>().updateLastName(
              newLastName: lastNameController.text,
            );
          },
        );
      },
      icon: AssetsData.personIcon,
      isTrailingIcon: true,
    );
  }
}
