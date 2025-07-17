import 'core/helpers/constants.dart';
import 'core/services/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  // Check if the user has seen the onboarding screen
  final bool hasSeenOnboarding = CacheHelper.getBool(key: kHasSeenOnboarding);
  runApp(MainApp(hasSeenOnboarding: hasSeenOnboarding));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.hasSeenOnboarding});
  final bool hasSeenOnboarding;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: const Locale("ar"),
      supportedLocales: const [Locale('ar')],
      theme: ThemeData(fontFamily: "Cairo"),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: AppRouter.createRouter(hasSeenOnboarding),
    );
  }
}
