import 'package:bio_app/core/functions/build_snack_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/get_user.dart';
import '../manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'edit_profile_dialog.dart';
import 'profile_avatar.dart';
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
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccessState) {
          successSnackBar(
            context: context,
            message: "تم تحديث الملف الشخصي بنجاح.",
          );
          setState(() {});
        } else if (state is EditProfileErrorState) {
          errorSnackBar(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is EditProfileLoadingState,
          child: SingleChildScrollView(
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
                          } else if (!AppRegex.isPhoneNumberValid(
                            value,
                          )) {
                            return "رقم الهاتف غير صالح";
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
