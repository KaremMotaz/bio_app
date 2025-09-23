import '../helpers/constants.dart';
import '../services/supabase_storage_service.dart';
import 'package:flutter/foundation.dart';

class SupabaseInitializer {
  static bool _initialized = false;

  static Future<void> initSafely() async {
    if (_initialized) {
      return;
    }

    try {
      await SupabaseStorageService.initSupabase();
      await SupabaseStorageService.createBuckets(kBucketName);

      _initialized = true;
    } catch (e, st) {
      debugPrint("❌ Supabase init failed: $e\n$st");
    }
  }
}
