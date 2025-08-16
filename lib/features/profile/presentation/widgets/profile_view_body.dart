import 'package:bio_app/core/helpers/get_user.dart';
import 'package:bio_app/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:bio_app/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'edit_profile_list_tile.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final TextEditingController fullNameController =
      TextEditingController();
  final TextEditingController phoneNumberController =
      TextEditingController(text: "1234567890");
  final TextEditingController emailController =
      TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              const ProfileAvatar(),
              const SizedBox(height: 20),
              EditProfileListTile(
                title: "الأسم الأول",
                subTitle: Text(
                  {
                    getUser().firstName!,
                    getUser().lastName!,
                  }.join(" "),
                ),
                onTap: () {
                  editProfileDialog(
                    context: context,
                    textInputType: TextInputType.name,
                    title: "تعديل الأسم الأول",
                    hintText: "أدخل الأسم الأول",
                    controller: fullNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "هذا الحقل مطلوب";
                      }
                      return null;
                    },
                  );
                },
                icon: Icons.person,
              ),
              const SizedBox(height: 10),
              EditProfileListTile(
                title: "الهاتف",
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
                        return "هذا الحقل مطلوب";
                      } else if (value.length < 10) {
                        return "رقم الهاتف يجب أن يكون 10 أرقام";
                      }
                      return null;
                    },
                  );
                },
                icon: Icons.phone,
                subTitle: Text(getUser().phoneNumber!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
