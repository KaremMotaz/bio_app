import 'core/services/get_it_service.dart';
import 'core/services/supabase_storage_service.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/helpers/constants.dart';
import 'core/services/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await SupabaseStorageService.initSupabase();
  await SupabaseStorageService.createBuckets(kBucketName);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupGetIt();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
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
      routerConfig: AppRouter.createRouter(),
    );
  }
}
