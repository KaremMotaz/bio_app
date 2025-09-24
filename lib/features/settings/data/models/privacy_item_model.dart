class PrivacyItemModel {
  final String title;
  final String description;

  const PrivacyItemModel({
    required this.title,
    required this.description,
  });

  static List<PrivacyItemModel> privacyItems = const [
    PrivacyItemModel(
      title: "جمع البيانات",
      description:
          "نقوم بجمع الحد الأدنى من البيانات اللازمة لتحسين تجربتك.",
    ),
    PrivacyItemModel(
      title: "استخدام البيانات",
      description:
          "تُستخدم بياناتك فقط لأغراض تعليمية وتحسين الأداء.",
    ),
    PrivacyItemModel(
      title: "مشاركة البيانات",
      description: "لن نشارك بياناتك مع أي طرف ثالث دون موافقتك.",
    ),
    PrivacyItemModel(
      title: "أمان البيانات",
      description:
          "نستخدم أحدث معايير التشفير لحماية بياناتك من الوصول غير المصرح به.",
    ),
  ];
}
