import 'package:flutter/material.dart';

import '../../../../../core/theming/text_styles.dart';

class PasswordValidations extends StatelessWidget {
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow("على الأقل حرف صغير واحد", hasLowerCase),
        SizedBox(height: 4),

        buildValidationRow("على الأقل حرف كبير واحد", hasUpperCase),
        SizedBox(height: 4),
        buildValidationRow("على الأقل رمز خاص واحد", hasSpecialCharacters),
        SizedBox(height: 4),
        buildValidationRow("على الأقل رقم واحد", hasNumber),
        SizedBox(height: 4),
        buildValidationRow("يجب أن يحتوي على 8 أحرف على الأقل", hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: hasValidated ? Colors.green : null,
          size: 16,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyles.regular14.copyWith(
            color: hasValidated ? Colors.green : null,
          ),
        ),
      ],
    );
  }
}
