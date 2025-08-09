import '../../../core/theming/assets_data.dart';
import 'models/quiz_question_model.dart';

final List<QuizQuestionModel> mockQuizQuestions = [
  QuizQuestionModel(
    index: 0,
    scenario:
        "تعرض ساق نبات نامٍ للضوء في اتجاه واحد لفترة زمنية ما :",
    questionText:
        "ما الرسم البياني الذي يعبر عن نمو خلايا الجانب البعيد عن الضوء من ساق هذا النبات ؟",
    options: [
      AssetsData.choiceOne,
      AssetsData.choiceTwo,
      AssetsData.choiceThree,
      AssetsData.choiceFour,
    ],
    correctIndex: 2,
    type: QuizQuestionType.imageOptions,
  ),
  QuizQuestionModel(
    index: 1,
    questionText: "أين يتم إنتاج خلايا الدم الحمراء؟",
    options: ["الكبد", "الطحال", "نخاع العظم", "القلب"],
    correctIndex: 2,
    explanation: "نخاع العظم هو المسؤول عن إنتاج خلايا الدم الحمراء.",
    images: [AssetsData.redBloodCells],
    type: QuizQuestionType.textOptions,
  ),
  QuizQuestionModel(
    index: 2,
    questionText: "كم عدد الكروموسومات في الخلية البشرية؟",
    options: ["23", "46", "44", "22"],
    correctIndex: 1,
    images: [AssetsData.chromosome],
    type: QuizQuestionType.textOptions,
  ),
  QuizQuestionModel(
    index: 3,
    questionText: "ما هو أصغر عظم في جسم الإنسان؟",
    options: ["عظمة الركاب", "العضد", "الفخذ", "الترقوة"],
    correctIndex: 0,
    type: QuizQuestionType.textOptions,
  ),
  QuizQuestionModel(
    index: 4,
    questionText: "ما هو الجزء المسؤول عن التنفس؟",
    options: ["القلب", "الكبد", "الرئتين", "الكلى"],
    correctIndex: 2,
    type: QuizQuestionType.textOptions,
  ),

  QuizQuestionModel(
    index: 5,
    questionText: "الخلايا النباتية تحتوي على جدار خلوي.",
    options: ["صح", "غلط"],
    correctIndex: 0,
    explanation:
        "الخلايا النباتية تحتوي على جدار خلوي يوفر لها الدعم والحماية.",
    type: QuizQuestionType.trueFalseOptions,
  ),
  QuizQuestionModel(
    index: 6,
    questionText: "القلب هو العضو المسؤول عن إنتاج الهرمونات.",
    options: ["صح", "غلط"],
    correctIndex: 1,
    explanation:
        "الغدد الصماء مثل الغدة الدرقية والكظرية هي المسؤولة عن إنتاج الهرمونات.",
    type: QuizQuestionType.trueFalseOptions,
  ),
  QuizQuestionModel(
    index: 7,
    questionText: "ما هي وحدة بناء البروتين؟",
    options: [
      "الأحماض النووية",
      "الأحماض الأمينية",
      "الدهون",
      "السكريات",
    ],
    correctIndex: 1,
    explanation: "الأحماض الأمينية ترتبط لتكوين البروتينات.",
    images: [AssetsData.protein],
    type: QuizQuestionType.textOptions,
  ),
  QuizQuestionModel(
    index: 8,
    questionText:
        "ما هو العضو الذي يُخزّن الجلوكوز على هيئة جلايكوجين؟",
    options: ["الكلى", "الكبد", "القلب", "الرئة"],
    correctIndex: 1,
    explanation:
        "الكبد يقوم بتخزين الجلوكوز الزائد على هيئة جلايكوجين.",
    images: [AssetsData.glucose],
    type: QuizQuestionType.textOptions,
  ),
  QuizQuestionModel(
    index: 9,
    questionText: "الميتوكوندريا تُعرف بأنها مصنع الطاقة في الخلية.",
    options: ["صح", "غلط"],
    correctIndex: 0,
    explanation:
        "الميتوكوندريا تقوم بإنتاج الطاقة من خلال التنفس الخلوي.",
    type: QuizQuestionType.trueFalseOptions,
  ),
];
