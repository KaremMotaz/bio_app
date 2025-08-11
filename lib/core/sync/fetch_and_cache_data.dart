import 'dart:developer';
import '../../features/units/data/repos/unit_repo_imp.dart';
import '../services/firestore_service.dart';
import '../services/get_it_service.dart';
import '../../features/chapters/data/data_source/chapters_local_data_source.dart';
import '../../features/chapters/data/models/chapter_model.dart';
import '../../features/lessons/data/data_source/lessons_local_data_source.dart';
import '../../features/lessons/data/data_source/quizzes_local_data_source.dart';
import '../../features/lessons/data/models/lesson_model.dart';
import '../../features/lessons/data/models/quiz_model.dart';
import '../../features/units/data/data_source/units_local_data_source.dart';
import '../../features/units/data/models/unit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../../../core/helpers/constants.dart';

Future<void> fetchAndCacheData() async {
  final firestoreService = getIt<FirestoreService>();
  final unitRepoImpl = getIt<UnitRepoImpl>();

  // 1. قراءة التوقيتات من السيرفر
  final lastUpdatesDoc = await FirebaseFirestore.instance
      .collection('metadata')
      .doc('last_updates')
      .get();

  final serverTimestamps = lastUpdatesDoc.data() ?? {};

  // 2. قراءة التوقيتات المحلية من Hive
  final hiveBox = Hive.box(kAppCacheBox);
  final localTimestamps = Map<String, dynamic>.from(
    hiveBox.get(kLastUpdatedTimestampsKey, defaultValue: {}),
  );

  // 3. تحديث الوحدات (Units)
  final serverUnitsTs =
      serverTimestamps[kUnitsLastUpdated] as Timestamp?;

  final localUnitsTs = localTimestamps[kUnits];

  if (_isNewer(serverUnitsTs, localUnitsTs)) {
    final List<UnitModel> units = (await unitRepoImpl.getUnits())
        .getOrElse(() => []);

    await getIt<UnitsLocalDataSource>().cacheUnits(units);
    localTimestamps[kUnits] = serverUnitsTs?.millisecondsSinceEpoch;
  }

  log(_isNewer(serverUnitsTs, localUnitsTs).toString());

  // 4. تحديث الفصول (Chapters)
  final serverChaptersTs =
      serverTimestamps[kChaptersLastUpdated] as Timestamp?;
  final localChaptersTs = localTimestamps[kChapters];
  if (_isNewer(serverChaptersTs, localChaptersTs)) {
    // هنا نفترض إنك عندك list بالـ units IDs
    final units = await unitRepoImpl.getUnits();
    final chaptersLocal = getIt<ChaptersLocalDataSource>();
    final allChapters = <ChapterModel>[];

    for (final unit in units.getOrElse(() => [])) {
      final rawData = await firestoreService.getData(
        path: 'units/${unit.id}/chapters', 
      );


  final List<ChapterModel> chapters = rawData
    .map<ChapterModel>((m) {
      return ChapterModel.fromJson({
        ...m as Map<String, dynamic>, 
        'unitId': unit.id,
      });
    })
    .toList();

      // تخزين كل Unit مع فصوله
      await chaptersLocal.cacheChapters(
        chapters: chapters,
        unitId: unit.id,
      );
      

      allChapters.addAll(chapters);
    }

    localTimestamps[kChapters] =
        serverChaptersTs?.millisecondsSinceEpoch;
  }

// 5. تحديث الكويزات (Quizzes)
final serverQuizzesTs =
    serverTimestamps[kQuizzesLastUpdated] as Timestamp?;
final localQuizzesTs = localTimestamps[kQuizzes];
if (_isNewer(serverQuizzesTs, localQuizzesTs)) {
  final units = await unitRepoImpl.getUnits();
  final quizzesLocal = getIt<QuizzesLocalDataSource>();

  for (final unit in units.getOrElse(() => [])) {
    // جلب الفصول داخل كل وحدة
    final chaptersData = await firestoreService.getData(
      path: 'units/${unit.id}/chapters',
    );

    for (final chapterMap in chaptersData) {
      final chapterId = chapterMap['id'] as String;

      // جلب الدروس داخل كل فصل
      final lessonsData = await firestoreService.getData(
        path: 'units/${unit.id}/chapters/$chapterId/lessons',
      );

      for (final lessonMap in lessonsData) {
        final lessonId = lessonMap['id'] as String;

        // جلب الكويزات داخل كل درس
        final quizzesData = await firestoreService.getData(
          path: 'units/${unit.id}/chapters/$chapterId/lessons/$lessonId/quizzes',
        );

        final List<QuizModel> quizzes = quizzesData.map<QuizModel>((m) {
          return QuizModel.fromJson({
            ...m as Map<String, dynamic>,
            'lessonId': lessonId,
            'chapterId': chapterId,
            'unitId': unit.id,
          });
        }).toList();

        await quizzesLocal.cacheQuizzes(
          quizzes: quizzes,
          lessonId: lessonId,
        );
      }
    }
  }

  localTimestamps[kQuizzes] = serverQuizzesTs?.millisecondsSinceEpoch;
}

// 6. تحديث الدروس (Lessons)
final serverLessonsTs =
    serverTimestamps[kLessonsLastUpdated] as Timestamp?;
final localLessonsTs = localTimestamps[kLessons];
if (_isNewer(serverLessonsTs, localLessonsTs)) {
  final units = await unitRepoImpl.getUnits();
  final lessonsLocal = getIt<LessonsLocalDataSource>();

  for (final unit in units.getOrElse(() => [])) {
    final chaptersData = await firestoreService.getData(
      path: 'units/${unit.id}/chapters',
    );

    for (final chapterMap in chaptersData) {
      final chapterId = chapterMap['id'] as String;

      final lessonsData = await firestoreService.getData(
        path: 'units/${unit.id}/chapters/$chapterId/lessons',
      );

      final List<LessonModel> lessons = lessonsData.map<LessonModel>((m) {
        return LessonModel.fromJson({
          ...m as Map<String, dynamic>,
          'chapterId': chapterId,
          'unitId': unit.id,
        });
      }).toList();

      await lessonsLocal.cacheLessons(
        lessons: lessons,
        chapterId: chapterId,
        unitId: unit.id,
      );
    }
  }

  localTimestamps[kLessons] = serverLessonsTs?.millisecondsSinceEpoch;
}


// 6. حفظ التوقيتات المحدثة
  await hiveBox.put(kLastUpdatedTimestampsKey, localTimestamps);
}  

/// مقارنة توقيت السيرفر مع التوقيت المحلي
bool _isNewer(Timestamp? server, dynamic local) {
  if (server == null) return false;
  if (local == null) return true;

  if (local is Timestamp) {
    return server.millisecondsSinceEpoch >
        local.millisecondsSinceEpoch;
  }
  if (local is int) {
    return server.millisecondsSinceEpoch > local;
  }
  return true;
}
