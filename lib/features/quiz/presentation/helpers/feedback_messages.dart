import 'dart:math';

class FeedbackMessages {
  static final List<String> _correctMessages = [
    "أحسنت! استمر.",
    "إجابة ممتازة!",
    "رائع! واصل التقدم.",
    "أداء مميز",
    "إجابة عبقرية!",
  ];

  static final List<String> _wrongMessages = [
    "قريبة جدًا! حاول مرةً أخرى.",
    "لا بأس، أعد المحاولة.",
    "خطأ بسيط! أنت قادر.",
    "نتعلم من أخطائنا. جرّب مجددًا.",
    "حاول التركيز أكثر في المرة القادمة.",
  ];

  static String getRandomCorrectMessage() {
    final random = Random();
    return _correctMessages[random.nextInt(_correctMessages.length)];
  }

  static String getRandomWrongMessage() {
    final random = Random();
    return _wrongMessages[random.nextInt(_wrongMessages.length)];
  }
}
