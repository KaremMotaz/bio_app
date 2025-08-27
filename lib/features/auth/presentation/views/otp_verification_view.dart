import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar_pop_icon.dart';
import 'widgets/otp_view_body_bloc_consumer.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تأكيد الايميل"),
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
      ),
      body: const SafeArea(child: OtpViewBodyBlocConsumer()),
    );
  }
}
