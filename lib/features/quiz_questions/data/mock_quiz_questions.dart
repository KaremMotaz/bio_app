import '../../../core/theming/assets_data.dart';
import 'models/quiz_question_model.dart';

final List<QuizQuestionModel> mockQuizQuestions = [
  QuizQuestionModel(
    id: 0,
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
    type: QuizQuestionType.imageChoices,
  ),
  QuizQuestionModel(
    id: 1,
    questionText: "أين يتم إنتاج خلايا الدم الحمراء؟",
    options: ["الكبد", "الطحال", "نخاع العظم", "القلب"],
    correctIndex: 2,
    explanation: "نخاع العظم هو المسؤول عن إنتاج خلايا الدم الحمراء.",
    images: [AssetsData.redBloodCells],
    type: QuizQuestionType.textChoices,
  ),
  QuizQuestionModel(
    id: 2,
    questionText: "كم عدد الكروموسومات في الخلية البشرية؟",
    options: ["23", "46", "44", "22"],
    correctIndex: 1,
    images: [AssetsData.chromosome],
    type: QuizQuestionType.textChoices,
  ),
  QuizQuestionModel(
    id: 3,
    questionText: "ما هو أصغر عظم في جسم الإنسان؟",
    options: ["عظمة الركاب", "العضد", "الفخذ", "الترقوة"],
    correctIndex: 0,
    type: QuizQuestionType.textChoices,
  ),
  QuizQuestionModel(
    id: 4,
    questionText: "ما هو الجزء المسؤول عن التنفس؟",
    options: ["القلب", "الكبد", "الرئتين", "الكلى"],
    correctIndex: 2,
    type: QuizQuestionType.textChoices,
  ),

  QuizQuestionModel(
    id: 5,
    questionText: "الخلايا النباتية تحتوي على جدار خلوي.",
    options: ["صح", "غلط"],
    correctIndex: 0,
    explanation:
        "الخلايا النباتية تحتوي على جدار خلوي يوفر لها الدعم والحماية.",
    type: QuizQuestionType.trueFalse,
  ),
  QuizQuestionModel(
    id: 6,
    questionText: "القلب هو العضو المسؤول عن إنتاج الهرمونات.",
    options: ["صح", "غلط"],
    correctIndex: 1,
    explanation:
        "الغدد الصماء مثل الغدة الدرقية والكظرية هي المسؤولة عن إنتاج الهرمونات.",
    type: QuizQuestionType.trueFalse,
  ),
  QuizQuestionModel(
    id: 7,
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
    type: QuizQuestionType.textChoices,
  ),
  QuizQuestionModel(
    id: 8,
    questionText:
        "ما هو العضو الذي يُخزّن الجلوكوز على هيئة جلايكوجين؟",
    options: ["الكلى", "الكبد", "القلب", "الرئة"],
    correctIndex: 1,
    explanation:
        "الكبد يقوم بتخزين الجلوكوز الزائد على هيئة جلايكوجين.",
    images: [AssetsData.glucose],
    type: QuizQuestionType.textChoices,
  ),
  QuizQuestionModel(
    id: 9,
    questionText: "الميتوكوندريا تُعرف بأنها مصنع الطاقة في الخلية.",
    options: ["صح", "غلط"],
    correctIndex: 0,
    explanation:
        "الميتوكوندريا تقوم بإنتاج الطاقة من خلال التنفس الخلوي.",
    type: QuizQuestionType.trueFalse,
  ),
  QuizQuestionModel(
    id: 10,
    questionText: "ما هو الإنزيم الذي يهضم النشويات في الفم؟",
    options: ["الببسين", "الأميليز", "الليباز", "التربسين"],
    correctIndex: 1,
    explanation:
        "الأميليز يُفرز من الغدد اللعابية ويبدأ بهضم النشويات في الفم.",
    type: QuizQuestionType.textChoices,
  ),
];
