class TermsItemModel {
  final String title;
  final String content;

  TermsItemModel({required this.title, required this.content});
  static final List<TermsItemModel> termsItems = [
    TermsItemModel(
      title: "١- الاستخدام المقبول",
      content:
          "يجب استخدام التطبيق للأغراض التعليمية فقط، وعدم إساءة استخدامه في أي أنشطة مخالفة للقوانين.",
    ),
    TermsItemModel(
      title: "٢- المحتوى",
      content:
          "جميع المحتوى والاختبارات هي ملكية فكرية محمية. لا يجوز إعادة توزيعها أو استخدامها لأغراض تجارية.",
    ),
    TermsItemModel(
      title: "٣- الحسابات",
      content:
          "أنت مسؤول عن سرية بيانات تسجيل الدخول الخاصة بك وأي نشاط يتم عبر حسابك.",
    ),
    TermsItemModel(
      title: "٤- التعديلات",
      content:
          "يحق للتطبيق تعديل أو تحديث هذه الشروط في أي وقت وسيتم إعلامك بأي تغييرات هامة.",
    ),
  ];
}
