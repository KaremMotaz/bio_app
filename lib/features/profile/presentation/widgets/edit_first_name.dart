import '../../../../core/helpers/get_user.dart';
import '../../../../core/theming/assets_data.dart';
import '../manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'edit_profile_dialog.dart';
import '../../../settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditFirstName extends StatelessWidget {
  const EditFirstName({super.key, required this.firstNameController});

  final TextEditingController firstNameController;

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      title: "الأسم الأول",
      subTitle: Text(getUser().firstName ?? ""),
      onTap: () {
        editProfileDialog(
          context: context,
          textInputType: TextInputType.name,
          title: "تعديل الأسم الأول",
          hintText: "أدخل الأسم الأول",
          controller: firstNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "يرجي أدخال الأسم الأول";
            }
            return null;
          },
          onPressed: () {
            context.read<EditProfileCubit>().updateFirstName(
              newFirstName: firstNameController.text,
            );
          },
        );
      },
      icon: AssetsData.personIcon,
      isTrailingIcon: true,
    );
  }
}
