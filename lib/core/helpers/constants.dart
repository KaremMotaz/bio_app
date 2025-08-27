const String kHasSeenOnboarding = "hasSeenOnboarding";
const String kUserData = "userData";
const String kBucketName = "users-images";
const String kUnitsBox = "units_box";
const String kUnits = "units";
const String kChaptersBox = "chapters_box";
const String kChapters = "chapters";
const String kLessonsBox = "lessons_box";
const String kLessons = "lessons";
const String kQuizzesBox = "quizzes_box";
const String kQuizQuestionsBox = "quiz_questions_box";
const String kQuizzes = "quizzes";
const String kQuizQuestions = "quizQuestions";
const String kAppCacheBox = 'app_cache';
const String kLastUpdatedTimestampsKey = 'last_updated_timestamps';
const String kUnitsLastUpdated = 'units_last_updated';
const String kChaptersLastUpdated = 'chapters_last_updated';
const String kLessonsLastUpdated = 'lessons_last_updated';
const String kQuizzesLastUpdated = 'quizzes_last_updated';
const String kQuizzesQuestionsLastUpdated = 'quizzes_questions_last_updated';
const String kExamsLastUpdated = 'exams_last_updated';
const String kExamsQuestionsLastUpdated = 'exams_questions_last_updated';
const String kExams = "exams";
const String kExamsBox = "exams_box";
const String kExamsQuestions = "examsQuestions";
const String kExamsQuestionsBox = "exams_questions_box";
const String kExamsAnswers = "examsAnswers";
const String kExamsAnswersBox = "exams_answers_box";

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
