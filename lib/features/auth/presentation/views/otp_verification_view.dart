import 'widgets/otp_view_body_bloc_consumer.dart';
import 'package:flutter/material.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تأكيد الايميل")),
      body: const SafeArea(
        child: OtpViewBodyBlocConsumer(),
      ),
    );
  }
}
