import 'package:bio_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/app_text_button.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../manager/fill_profile_cubit/fill_profile_cubit.dart';

class FillProfileForm extends StatefulWidget {
  const FillProfileForm({super.key});

  @override
  State<FillProfileForm> createState() => _FillProfileFormState();
}

class _FillProfileFormState extends State<FillProfileForm> {
  final TextEditingController firstNameController =
      TextEditingController();
  final TextEditingController lastNameController =
      TextEditingController();
  final TextEditingController phoneNumberController =
      TextEditingController();
  String? selectedGrade; // Store selected grade
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            AppTextFormField(
              hintText: "الاسم الأول",
              controller: firstNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "يرجى إدخال الاسم الأول";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextFormField(
              hintText: "الاسم الأخير",
              controller: lastNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "يرجى إدخال الاسم الأخير";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextFormField(
              textInputType: TextInputType.phone,
              hintText: "رقم الهاتف",
              controller: phoneNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "يرجى إدخال رقم الهاتف";
                }
                if (!AppRegex.isPhoneNumberValid(value)) {
                  return "يرجى إدخال رقم هاتف صالح";
                }
                return null;
              },
            ),
            const SizedBox(height: 32), // Add spacing between fields
            AppTextButton(
              buttonText: "تأكيد",
              textStyle: TextStyles.semiBold16.copyWith(
                color: AppColors.white,
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await context.read<FillProfileCubit>().fillProfile(
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    phoneNumberController: phoneNumberController,
                  );
                  firstNameController.clear();
                  lastNameController.clear();
                  phoneNumberController.clear();
                  selectedGrade = null;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
