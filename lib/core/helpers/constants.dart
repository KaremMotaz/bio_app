const String kHasSeenOnboarding = "hasSeenOnboarding";
const String kUserData = "userData";
const String kBucketName = "users-images";
const String kUnitsBox = "units_box";
const String kUnits = "units";
const String kChaptersBox = "chapters_box";
const String kChapters = "chapters";
const String kLessonsBox = "lessons_box";
const String kLessons = "lessons";

String getDisplayNumber(int id) {
  const numbers = [
    'الأول',
    'الثاني',
    'الثالث',
    'الرابع',
    'الخامس',
    'السادس',
    'السابع',
    'الثامن',
    'التاسع',
    'العاشر',
  ];
  return id >= 0 && id < numbers.length ? numbers[id] : 'غير معروف';
}
