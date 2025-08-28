import 'package:bio_app/bio_app.dart';
import 'package:bio_app/core/config/daily_tasks_config.dart';
import 'package:bio_app/core/config/hive_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/services/cache_helper.dart';
import 'core/services/get_it_service.dart';
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

  runApp(const BioApp());
}
