import '../../../../core/theming/assets_data.dart';

extension RatingMessageX on double {
  String get ratingFeedback {
    if (this == 0) {
      return "نعتذر عن التجربة السيئة وسنحاول تحسين التطبيق.";
    }
    if (this <= 1) {
      return "سنعمل على إصلاح المشكلات لجعل تجربتك أفضل.";
    }
    if (this <= 2) return "نشكرك على ملاحظاتك وسنسعى للتحسين.";
    if (this <= 3) return "سعداء برضاك وسنستمر في التحسين.";
    if (this <= 4) return "شكراً على دعمك، سنعمل بجهد أكبر.";
    return "ممتنون جداً لرضاك التام ❤️";
  }

  String get ratingEmojiAsset {
    if (this == 0) return AssetsData.cryingFace;
    if (this <= 1) return AssetsData.cryingFace;
    if (this <= 2) return AssetsData.worriedFace;
    if (this <= 3) return AssetsData.neutralFace;
    if (this <= 4) return AssetsData.faceWithSmilingEyes;
    return AssetsData.smilingFaceWithHeartEyes;
  }
}
