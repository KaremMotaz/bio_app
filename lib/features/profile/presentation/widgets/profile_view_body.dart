import 'package:bio_app/core/helpers/get_user.dart';
import 'package:bio_app/features/profile/presentation/manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:bio_app/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:bio_app/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_profile_list_tile.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final TextEditingController firstNameController =
      TextEditingController(text: getUser().firstName!);
  final TextEditingController lastNameController =
      TextEditingController(text: getUser().lastName!);
  final TextEditingController phoneNumberController =
      TextEditingController(text: getUser().phoneNumber!);

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
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
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              return Column(
                children: [
                  const ProfileAvatar(),
                  const SizedBox(height: 20),
                  EditProfileListTile(
                    title: "الأسم الأول",
                    subTitle: Text(getUser().firstName!),
                    onTap: () {
                      editProfileDialog(
                        context: context,
                        textInputType: TextInputType.name,
                        title: "تعديل الأسم الأول",
                        hintText: "أدخل الأسم الأول",
                        controller: firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "يجب أدخال الأسم الأول";
                          }
                          return null;
                        },
                        onPressed: () {
                          context
                              .read<EditProfileCubit>()
                              .updateFirstName(
                                newFirstName:
                                    firstNameController.text,
                              );
                        },
                      );
                    },
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  EditProfileListTile(
                    title: "الأسم الأخير",
                    subTitle: Text(getUser().lastName!),
                    onTap: () {
                      editProfileDialog(
                        context: context,
                        textInputType: TextInputType.name,
                        title: "تعديل الأسم الأخير",
                        hintText: "أدخل الأسم الأخير",
                        controller: lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "هذا الحقل مطلوب";
                          }
                          return null;
                        },
                        onPressed: () {
                          context
                              .read<EditProfileCubit>()
                              .updateLastName(
                                newLastName: lastNameController.text,
                              );
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
                        onPressed: () {
                          context
                              .read<EditProfileCubit>()
                              .updatePhoneNumber(
                                newPhoneNumber:
                                    phoneNumberController.text,
                              );
                        },
                      );
                    },
                    icon: Icons.phone,
                    subTitle: Text(getUser().phoneNumber!),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
