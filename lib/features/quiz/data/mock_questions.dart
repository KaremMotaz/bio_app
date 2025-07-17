import '../../../core/theming/assets_data.dart';
import 'models/question_model.dart';

final List<QuestionModel> mockQuestions = [
  QuestionModel(
    questionScenario: "تعرض ساق نبات نامٍ للضوء في اتجاه واحد لفترة زمنية ما :",
    questionText:
        "ما الرسم البياني الذي يعبر عن نمو خلايا الجانب البعيد عن الضوء من ساق هذا النبات ؟",
    options: [
      AssetsData.choiceOne,
      AssetsData.choiceTwo,
      AssetsData.choiceThree,
      AssetsData.choiceFour,
    ],
    correctAnswerIndex: 2,
    questionType: QuestionType.imageChoices,
  ),
  QuestionModel(
    questionText: "أين يتم إنتاج خلايا الدم الحمراء؟",
    options: ["الكبد", "الطحال", "نخاع العظم", "القلب"],
    correctAnswerIndex: 2,
    explanation: "نخاع العظم هو المسؤول عن إنتاج خلايا الدم الحمراء.",
    questionImages: [AssetsData.redBloodCells],
    questionType: QuestionType.textChoices,
  ),
  QuestionModel(
    questionText: "كم عدد الكروموسومات في الخلية البشرية؟",
    options: ["23", "46", "44", "22"],
    correctAnswerIndex: 1,
    questionImages: [AssetsData.chromosome],
    questionType: QuestionType.textChoices,
  ),
  QuestionModel(
    questionText: "ما هو أصغر عظم في جسم الإنسان؟",
    options: ["عظمة الركاب", "العضد", "الفخذ", "الترقوة"],
    correctAnswerIndex: 0,
    questionType: QuestionType.textChoices,
  ),
  QuestionModel(
    questionText: "ما هو الجزء المسؤول عن التنفس؟",
    options: ["القلب", "الكبد", "الرئتين", "الكلى"],
    correctAnswerIndex: 2,
    questionType: QuestionType.textChoices,
  ),

  QuestionModel(
    questionText: "الخلايا النباتية تحتوي على جدار خلوي.",
    options: ["صح", "غلط"],
    correctAnswerIndex: 0,
    explanation:
        "الخلايا النباتية تحتوي على جدار خلوي يوفر لها الدعم والحماية.",
    questionType: QuestionType.trueFalse,
  ),
  QuestionModel(
    questionText: "القلب هو العضو المسؤول عن إنتاج الهرمونات.",
    options: ["صح", "غلط"],
    correctAnswerIndex: 1,
    explanation:
        "الغدد الصماء مثل الغدة الدرقية والكظرية هي المسؤولة عن إنتاج الهرمونات.",
    questionType: QuestionType.trueFalse,
  ),
  QuestionModel(
    questionText: "ما هي وحدة بناء البروتين؟",
    options: ["الأحماض النووية", "الأحماض الأمينية", "الدهون", "السكريات"],
    correctAnswerIndex: 1,
    explanation: "الأحماض الأمينية ترتبط لتكوين البروتينات.",
    questionImages: [AssetsData.protein],
    questionType: QuestionType.textChoices,
  ),
  QuestionModel(
    questionText: "ما هو العضو الذي يُخزّن الجلوكوز على هيئة جلايكوجين؟",
    options: ["الكلى", "الكبد", "القلب", "الرئة"],
    correctAnswerIndex: 1,
    explanation: "الكبد يقوم بتخزين الجلوكوز الزائد على هيئة جلايكوجين.",
    questionImages: [AssetsData.glucose],
    questionType: QuestionType.textChoices,
  ),
  QuestionModel(
    questionText: "الميتوكوندريا تُعرف بأنها مصنع الطاقة في الخلية.",
    options: ["صح", "غلط"],
    correctAnswerIndex: 0,
    explanation: "الميتوكوندريا تقوم بإنتاج الطاقة من خلال التنفس الخلوي.",
    questionType: QuestionType.trueFalse,
  ),
  QuestionModel(
    questionText: "ما هو الإنزيم الذي يهضم النشويات في الفم؟",
    options: ["الببسين", "الأميليز", "الليباز", "التربسين"],
    correctAnswerIndex: 1,
    explanation:
        "الأميليز يُفرز من الغدد اللعابية ويبدأ بهضم النشويات في الفم.",
    questionType: QuestionType.textChoices,
  ),
];
