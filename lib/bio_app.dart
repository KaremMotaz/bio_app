import 'dart:async';
import 'package:bio_app/core/config/init_supabase_safely.dart';
import 'package:bio_app/core/routing/app_router.dart';
import 'package:bio_app/core/routing/no_internet_router.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class BioApp extends StatefulWidget {
  const BioApp({super.key});

  @override
  State<BioApp> createState() => _BioAppState();
}

class _BioAppState extends State<BioApp> {
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
          : NoInternetRouter.createRouter(isConnected: _isConnected),
    );
  }
}
