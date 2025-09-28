import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code = "SERVER_FAILURE",
  });

  factory ServerFailure.fromResponse(
    int statusCode,
    dynamic response,
  ) {
    final String defaultMessage =
        response is Map && response['error']?['message'] != null
            ? response['error']['message'].toString()
            : "حدث خطأ غير متوقع، يرجى المحاولة لاحقاً.";

    switch (statusCode) {
      case 400:
        return const ServerFailure(
          message: "الطلب غير صحيح. يرجى التحقق من البيانات المدخلة.",
          code: "BAD_REQUEST",
        );
      case 401:
        return const ServerFailure(
          message: "غير مصرح لك. يرجى تسجيل الدخول أولاً.",
          code: "UNAUTHORIZED",
        );
      case 403:
        return const ServerFailure(
          message: "لا تملك صلاحية للوصول إلى هذه الخدمة.",
          code: "FORBIDDEN",
        );
      case 404:
        return const ServerFailure(
          message: "المورد المطلوب غير موجود.",
          code: "NOT_FOUND",
        );
      case 408:
        return const ServerFailure(
          message: "انتهت مهلة الطلب. يرجى المحاولة مجدداً.",
          code: "TIMEOUT",
        );
      case 409:
        return const ServerFailure(
          message: "حدث تعارض في البيانات. يرجى إعادة المحاولة لاحقاً.",
          code: "CONFLICT",
        );
      case 429:
        return const ServerFailure(
          message: "تم إرسال طلبات كثيرة. يرجى الانتظار قليلاً ثم إعادة المحاولة.",
          code: "TOO_MANY_REQUESTS",
        );
      case 500:
        return const ServerFailure(
          message: "خطأ داخلي في الخادم. يرجى المحاولة لاحقاً.",
          code: "INTERNAL_ERROR",
        );
      case 502:
        return const ServerFailure(
          message: "استجابة غير صحيحة من الخادم. يرجى إعادة المحاولة.",
          code: "BAD_GATEWAY",
        );
      case 503:
        return const ServerFailure(
          message: "الخدمة غير متاحة حالياً. يرجى المحاولة لاحقاً.",
          code: "SERVICE_UNAVAILABLE",
        );
      case 504:
        return const ServerFailure(
          message: "الخادم لم يستجب في الوقت المحدد. يرجى إعادة المحاولة.",
          code: "GATEWAY_TIMEOUT",
        );
      default:
        return ServerFailure(
          message: defaultMessage,
          code: "UNKNOWN_STATUS_$statusCode",
        );
    }
  }

  /// معالجة أخطاء Firebase
  factory ServerFailure.fromFirebaseException(FirebaseException e) {
    switch (e.code) {
      case "permission-denied":
        return const ServerFailure(
          message: "ليست لديك صلاحية لتنفيذ هذا الإجراء.",
          code: "PERMISSION_DENIED",
        );
      case "unavailable":
        return const ServerFailure(
          message: "الخدمة غير متوفرة حالياً. يرجى المحاولة لاحقاً.",
          code: "UNAVAILABLE",
        );
      case "unauthenticated":
        return const ServerFailure(
          message: "يرجى تسجيل الدخول للمتابعة.",
          code: "UNAUTHENTICATED",
        );
      case "not-found":
        return const ServerFailure(
          message: "العنصر المطلوب غير موجود.",
          code: "NOT_FOUND",
        );
      case "already-exists":
        return const ServerFailure(
          message: "العنصر موجود بالفعل.",
          code: "ALREADY_EXISTS",
        );
      case "deadline-exceeded":
        return const ServerFailure(
          message: "انتهى وقت الطلب. يرجى إعادة المحاولة.",
          code: "DEADLINE_EXCEEDED",
        );
      default:
        return ServerFailure(
          message: e.message ?? "حدث خطأ غير متوقع في قاعدة البيانات.",
          code: e.code,
        );
    }
  }

  /// معالجة أخطاء Platform
  factory ServerFailure.fromPlatformException(PlatformException e) {
    switch (e.code) {
      case "network_error":
        return const ServerFailure(
          message: "لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة.",
          code: "NETWORK_ERROR",
        );
      case "invalid_argument":
        return const ServerFailure(
          message: "تم إدخال بيانات غير صحيحة.",
          code: "INVALID_ARGUMENT",
        );
      case "timeout":
        return const ServerFailure(
          message: "انتهت مهلة العملية. يرجى المحاولة مجدداً.",
          code: "TIMEOUT",
        );
      default:
        return ServerFailure(
          message: e.message ?? "حدث خطأ في النظام.",
          code: e.code,
        );
    }
  }

  /// خطأ غير معروف
  factory ServerFailure.unknown([String? details]) => ServerFailure(
        message: "حدث خطأ غير متوقع. ${details ?? ""}",
        code: "UNKNOWN",
      );
}
