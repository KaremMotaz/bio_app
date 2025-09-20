import 'package:bio_app/core/widgets/custom_app_bar_pop_icon.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? const CustomAppBarPopIcon()
            : null,
        title: const Text("الإشعارات"),
      ),
      body: const Column(
        children: [Center(child: Text("Notifications"))],
      ),
    );
  }
}
