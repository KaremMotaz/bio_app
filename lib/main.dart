import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/helpers/constants.dart';
import 'core/routing/app_router.dart';
import 'core/services/cache_helper.dart';
import 'core/services/get_it_service.dart';
import 'core/services/supabase_storage_service.dart';
import 'core/theming/text_styles.dart';
import 'firebase_options.dart';
import 'package:flutter_sha_fingerprint/flutter_sha_fingerprint.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterShaFingerprint.getFingerprints();

  await Hive.initFlutter();
  await Hive.openBox(kUnitsBox);
  await Hive.openBox(kChaptersBox);
  await Hive.openBox(kLessonsBox);
  await Hive.openBox(kQuizzesBox);
  await Hive.openBox(kQuizQuestionsBox);
  await Hive.openBox(kAppCacheBox);
  await Hive.openBox(kExamsBox);
  await Hive.openBox(kExamsQuestionsBox);
  await Hive.openBox(kExamsAnswersBox);
  await SupabaseStorageService.initSupabase();
  await SupabaseStorageService.createBuckets(kBucketName);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  setupGetIt();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: const Locale("ar"),
      supportedLocales: const [Locale('ar')],
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyles.bold18.copyWith(
            color: Colors.black,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: AppRouter.createRouter(),
    );
  }
}
