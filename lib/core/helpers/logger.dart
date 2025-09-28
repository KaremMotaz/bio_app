import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class Logger {
  static void log(String message) {
    if (kDebugMode) {
      developer.log(message);
    }
  }
}
