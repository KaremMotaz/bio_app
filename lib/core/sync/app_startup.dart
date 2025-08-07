import 'package:bio_app/core/sync/fetch_and_cache_data.dart';

class AppStartup {
  // Singleton: نسخة واحدة فقط من الكلاس
  AppStartup._internal();
  static final AppStartup instance = AppStartup._internal();

  bool _hasRun = false;

  Future<void> runOnce() async {
    if (_hasRun) return;
    _hasRun = true;

    await fetchAndCacheData();
  }
}
