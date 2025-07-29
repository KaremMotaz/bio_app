import 'package:flutter/material.dart';

import 'edit_profile_list_tile.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() =>
      _ProfileViewBodyState();
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
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              // const Align(child: CustomCircleAvatar()),
              SizedBox(height: 30),
              EditProfileListTile(
                title: "الاسم",
                subTitle: const Text('Karim Motaz'),
                onTap: () {
                  // editProfileDialog(
                  //   context: context,
                  //   textInputType: TextInputType.name,
                  //   title: S.of(context).enter_name_title,
                  //   hintText: S.of(context).name_hint,
                  //   controller: fullNameController,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return S
                  //           .of(context)
                  //           .name_validation;
                  //     }
                  //     return null;
                  //   },
                  // );
                },
                icon: Icons.person,
              ),
              SizedBox(height: 10),
              EditProfileListTile(
                title: "الهاتف",
                onTap: () {
                  // editProfileDialog(
                  //   context: context,
                  //   textInputType: TextInputType.phone,
                  //   title: S.of(context).enter_phone_title,
                  //   hintText: S.of(context).phone_hint,
                  //   controller: phoneNumberController,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       phoneNumberController.clear();
                  //       return S
                  //           .of(context)
                  //           .phone_validation;
                  //     }
                  //   },
                  // );
                },
                icon: Icons.phone,
                subTitle: const Text('01010424919'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
