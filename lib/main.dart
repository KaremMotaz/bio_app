import 'dart:async';
import 'package:bio_app/core/config/daily_tasks_config.dart';
import 'package:bio_app/core/config/hive_config.dart';
import 'package:bio_app/core/config/init_supabase_safely.dart';
import 'package:bio_app/core/routing/no_internet_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'core/routing/app_router.dart';
import 'core/services/cache_helper.dart';
import 'core/services/get_it_service.dart';
import 'core/theming/text_styles.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CacheHelper.init();

  setupGetIt();

  await DailyTasksConfig.init();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isConnected = true;
  StreamSubscription? _connectivitySubscription;
  @override
  void initState() {
    _connectivitySubscription = InternetConnection().onStatusChange
        .listen((status) {
          setState(() {
            switch (status) {
              case InternetStatus.connected:
                _isConnected = true;
                SupabaseInitializer.initSafely();
                break;
              case InternetStatus.disconnected:
                _isConnected = false;
                break;
            }
          });
        });
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

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
          titleTextStyle: TextStyles.bold17.copyWith(
            fontFamily: 'Cairo',
            color: Colors.grey.shade600,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: _isConnected
          ? AppRouter.createRouter()
          : NoInternetRouter.createRouter(),
    );
  }
}
