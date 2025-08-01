import '../../../../core/models/exam_question_model.dart';
import '../../../../core/theming/assets_data.dart';

final List<Map<String, dynamic>> biologyQuestions = [
  {
    "id": 0,
    "scenario":
        "تعرض ساق نبات نامٍ للضوء في اتجاه واحد لفترة زمنية ما :",
    "text":
        "ما الرسم البياني الذي يعبر عن نمو خلايا الجانب البعيد عن الضوء من ساق هذا النبات ؟",
    "type": ExamOptionsType.imageOptions,
    "options": [
      AssetsData.choiceOne,
      AssetsData.choiceTwo,
      AssetsData.choiceThree,
      AssetsData.choiceFour,
    ],
    "correctIndex": 2,
    "marks": 2,
  },
  {
    "id": 1,
    "text": "أين يتم إنتاج خلايا الدم الحمراء؟",
    "type": ExamOptionsType.textOptions,
    "options": ["الكبد", "الطحال", "نخاع العظم", "القلب"],
    "correctIndex": 2,
    "marks": 2,
    "images": [AssetsData.redBloodCells],
    "explanation":
        "نخاع العظم هو المسؤول عن إنتاج خلايا الدم الحمراء.",
  },
  {
    "id": 2,
    "text": "كم عدد الكروموسومات في الخلية البشرية؟",
    "type": ExamOptionsType.textOptions,
    "options": ["23", "46", "44", "22"],
    "correctIndex": 1,
    "marks": 2,
    "images": [AssetsData.chromosome],
  },
  {
    "id": 3,
    "text": "ما هو أصغر عظم في جسم الإنسان؟",
    "type": ExamOptionsType.textOptions,
    "options": ["عظمة الركاب", "العضد", "الفخذ", "الترقوة"],
    "correctIndex": 0,
    "marks": 2,
  },
  {
    "id": 4,
    "text": "ما هو الجزء المسؤول عن التنفس؟",
    "type": ExamOptionsType.textOptions,
    "options": ["القلب", "الكبد", "الرئتين", "الكلى"],
    "correctIndex": 2,
    "marks": 2,
  },
  {
    "id": 5,
    "text": "الخلايا النباتية تحتوي على جدار خلوي.",
    "type": ExamOptionsType.trueFalseOptions,
    "options": ["صح", "غلط"],
    "correctIndex": 0,
    "marks": 2,
    "explanation":
        "الخلايا النباتية تحتوي على جدار خلوي يوفر لها الدعم والحماية.",
  },
  {
    "id": 6,
    "text": "القلب هو العضو المسؤول عن إنتاج الهرمونات.",
    "type": ExamOptionsType.trueFalseOptions,
    "options": ["صح", "غلط"],
    "correctIndex": 1,
    "marks": 2,
    "explanation":
        "الغدد الصماء مثل الغدة الدرقية والكظرية هي المسؤولة عن إنتاج الهرمونات.",
  },
  {
    "id": 7,
    "text": "ما هي وحدة بناء البروتين؟",
    "type": ExamOptionsType.textOptions,
    "options": [
      "الأحماض النووية",
      "الأحماض الأمينية",
      "الدهون",
      "السكريات",
    ],
    "correctIndex": 1,
    "marks": 2,
    "images": [AssetsData.protein],
    "explanation":
        "الأحماض الأمينية ترتبط لتكوين البروتينات.",
  },
  {
    "id": 8,
    "text":
        "ما هو العضو الذي يُخزّن الجلوكوز على هيئة جلايكوجين؟",
    "type": ExamOptionsType.textOptions,
    "options": ["الكلى", "الكبد", "القلب", "الرئة"],
    "correctIndex": 1,
    "marks": 2,
    "images": [AssetsData.glucose],
    "explanation":
        "الكبد يقوم بتخزين الجلوكوز الزائد على هيئة جلايكوجين.",
  },
  {
    "id": 9,
    "text":
        "الميتوكوندريا تُعرف بأنها مصنع الطاقة في الخلية.",
    "type": ExamOptionsType.trueFalseOptions,
    "options": ["صح", "غلط"],
    "correctIndex": 0,
    "marks": 2,
    "explanation":
        "الميتوكوندريا تقوم بإنتاج الطاقة من خلال التنفس الخلوي.",
  },
  {
    "id": 10,
    "text": "ما هو الإنزيم الذي يهضم النشويات في الفم؟",
    "type": ExamOptionsType.textOptions,
    "options": [
      "الببسين",
      "الأميليز",
      "الليباز",
      "التربسين",
    ],
    "correctIndex": 1,
    "marks": 2,
    "explanation":
        "الأميليز يُفرز من الغدد اللعابية ويبدأ بهضم النشويات في الفم.",
  },
];
