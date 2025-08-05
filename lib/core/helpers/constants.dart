const String kHasSeenOnboarding = "hasSeenOnboarding";
const String kUserData = "userData";
const String kBucketName = "users-images";

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
