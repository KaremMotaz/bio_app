import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key, required this.isConnected});
  final bool isConnected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: isConnected
              ? Center(
                  child: Icon(
                    Icons.wifi,
                    size: 100,
                    color: Colors.green.shade600,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off_rounded,
                      size: 100,
                      color: Colors.red.shade600,
                    ),
                    const SizedBox(height: 24),

                    Text(
                      "لا يوجد اتصال بالإنترنت",
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "تأكد من اتصالك وحاول مرة أخرى.\nقد تحتاج لإعادة تشغيل الراوتر أو التحقق من الشبكة.",
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
