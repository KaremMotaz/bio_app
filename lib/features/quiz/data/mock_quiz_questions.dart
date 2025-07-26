import '../../../core/theming/assets_data.dart';
import 'models/quiz_question_model.dart';

final List<QuizQuestionModel> mockQuizQuestions = [
  QuizQuestionModel(
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
    correctAnswerIndex: 2,
    type: QuizQuestionType.imageChoices,
  ),
  QuizQuestionModel(
    questionText: "أين يتم إنتاج خلايا الدم الحمراء؟",
    options: ["الكبد", "الطحال", "نخاع العظم", "القلب"],
    correctAnswerIndex: 2,
    explanation:
        "نخاع العظم هو المسؤول عن إنتاج خلايا الدم الحمراء.",
    questionImages: [AssetsData.redBloodCells],
    type: QuizQuestionType.textChoices,
  ),
  QuizQuestionModel(
    questionText: "كم عدد الكروموسومات في الخلية البشرية؟",
    options: ["23", "46", "44", "22"],
    correctAnswerIndex: 1,
    questionImages: [AssetsData.chromosome],
    type: QuizQuestionType.textChoices,
  ),
  QuizQuestionModel(
    questionText: "ما هو أصغر عظم في جسم الإنسان؟",
    options: ["عظمة الركاب", "العضد", "الفخذ", "الترقوة"],
    correctAnswerIndex: 0,
    type: QuizQuestionType.textChoices,
  ),
  QuizQuestionModel(
    questionText: "ما هو الجزء المسؤول عن التنفس؟",
    options: ["القلب", "الكبد", "الرئتين", "الكلى"],
    correctAnswerIndex: 2,
    type: QuizQuestionType.textChoices,
  ),

  QuizQuestionModel(
    questionText: "الخلايا النباتية تحتوي على جدار خلوي.",
    options: ["صح", "غلط"],
    correctAnswerIndex: 0,
    explanation:
        "الخلايا النباتية تحتوي على جدار خلوي يوفر لها الدعم والحماية.",
    type: QuizQuestionType.trueFalse,
  ),
  QuizQuestionModel(
    questionText:
        "القلب هو العضو المسؤول عن إنتاج الهرمونات.",
    options: ["صح", "غلط"],
    correctAnswerIndex: 1,
    explanation:
        "الغدد الصماء مثل الغدة الدرقية والكظرية هي المسؤولة عن إنتاج الهرمونات.",
    type: QuizQuestionType.trueFalse,
  ),
  QuizQuestionModel(
    questionText: "ما هي وحدة بناء البروتين؟",
    options: [
      "الأحماض النووية",
      "الأحماض الأمينية",
      "الدهون",
      "السكريات",
    ],
    correctAnswerIndex: 1,
    explanation:
        "الأحماض الأمينية ترتبط لتكوين البروتينات.",
    questionImages: [AssetsData.protein],
    type: QuizQuestionType.textChoices,
  ),
  QuizQuestionModel(
    questionText:
        "ما هو العضو الذي يُخزّن الجلوكوز على هيئة جلايكوجين؟",
    options: ["الكلى", "الكبد", "القلب", "الرئة"],
    correctAnswerIndex: 1,
    explanation:
        "الكبد يقوم بتخزين الجلوكوز الزائد على هيئة جلايكوجين.",
    questionImages: [AssetsData.glucose],
    type: QuizQuestionType.textChoices,
  ),
  QuizQuestionModel(
    questionText:
        "الميتوكوندريا تُعرف بأنها مصنع الطاقة في الخلية.",
    options: ["صح", "غلط"],
    correctAnswerIndex: 0,
    explanation:
        "الميتوكوندريا تقوم بإنتاج الطاقة من خلال التنفس الخلوي.",
    type: QuizQuestionType.trueFalse,
  ),
  QuizQuestionModel(
    questionText:
        "ما هو الإنزيم الذي يهضم النشويات في الفم؟",
    options: ["الببسين", "الأميليز", "الليباز", "التربسين"],
    correctAnswerIndex: 1,
    explanation:
        "الأميليز يُفرز من الغدد اللعابية ويبدأ بهضم النشويات في الفم.",
    type: QuizQuestionType.textChoices,
  ),
];
