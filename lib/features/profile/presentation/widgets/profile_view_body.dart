import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import 'edit_first_name.dart';
import 'edit_last_name.dart';
import 'edit_phone_number.dart';
import 'show_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../core/functions/build_snack_bar.dart';
import '../../../../core/helpers/get_user.dart';
import '../manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'profile_avatar.dart';

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
          progressIndicator: const CustomCircularProgressIndicator(
            color: AppColors.mainBlue,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                children: [
                  const ProfileAvatar(),
                  const SizedBox(height: 30),
                  const ShowEmail(),
                  const SizedBox(height: 20),
                  EditFirstName(
                    firstNameController: firstNameController,
                  ),
                  const SizedBox(height: 20),
                  EditLastName(
                    lastNameController: lastNameController,
                  ),
                  const SizedBox(height: 20),
                  EditPhoneNumber(
                    phoneNumberController: phoneNumberController,
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
