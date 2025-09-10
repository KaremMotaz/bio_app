import 'dart:async';
import 'package:bio_app/core/config/init_supabase_safely.dart';
import 'package:bio_app/core/routing/app_router.dart';
import 'package:bio_app/core/theming/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class BioticsApp extends StatefulWidget {
  const BioticsApp({super.key});

  @override
  State<BioticsApp> createState() => _BioticsAppState();
}

class _BioticsAppState extends State<BioticsApp> {
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
      theme: ThemeManager.getAppTheme(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: AppRouter.createRouter(isConnected: _isConnected),
    );
  }
}
