import 'dart:developer';
import '../helpers/backend_endpoint.dart';
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
    final List<Map<String, dynamic>> rawData = await firestoreService
        .getData(path: BackendEndpoint.getUnits);
    final List<UnitModel> units = rawData
        .map((m) => UnitModel.fromJson(m))
        .toList();
    await getIt<UnitsLocalDataSource>().cacheUnits(units);
    localTimestamps[kUnits] = serverUnitsTs?.millisecondsSinceEpoch;
  }

  log(_isNewer(serverUnitsTs, localUnitsTs).toString());

  // 4. تحديث الفصول (Chapters)
  final serverChaptersTs =
      serverTimestamps[kChaptersLastUpdated] as Timestamp?;
  final localChaptersTs = localTimestamps[kChapters];
  if (_isNewer(serverChaptersTs, localChaptersTs)) {
    final List<Map<String, dynamic>> rawData = await firestoreService
        .getData(path: BackendEndpoint.getChapters);

    final List<ChapterModel> chapters = rawData
        .map((m) => ChapterModel.fromJson(m))
        .toList();
    final chaptersLocal = getIt<ChaptersLocalDataSource>();

    // تخزين كل Unit مع فصوله
    final byUnit = <String, List<ChapterModel>>{};
    for (final c in chapters) {
      byUnit.putIfAbsent(c.unitId, () => []).add(c);
    }
    for (final entry in byUnit.entries) {
      await chaptersLocal.cacheChapters(
        chapters: entry.value,
        unitId: entry.key,
      );
    }

    localTimestamps[kChapters] =
        serverChaptersTs?.millisecondsSinceEpoch;
  }

  // 5. تحديث الكويزات (Quizzes)
  final serverQuizzesTs =
      serverTimestamps[kQuizzesLastUpdated] as Timestamp?;
  final localQuizzesTs = localTimestamps[kQuizzes];
  if (_isNewer(serverQuizzesTs, localQuizzesTs)) {
    final List<Map<String, dynamic>> rawData = await firestoreService
        .getData(path: BackendEndpoint.getQuizzes);

    final List<QuizModel> quizzes = rawData
        .map((m) => QuizModel.fromJson(m))
        .toList();
    final quizzesLocal = getIt<QuizzesLocalDataSource>();

    // تخزين كل Lesson مع كويزاته
    final byLesson = <int, List<QuizModel>>{};
    for (final q in quizzes) {
      byLesson.putIfAbsent(q.lessonId, () => []).add(q);
    }
    for (final entry in byLesson.entries) {
      await quizzesLocal.cacheQuizzes(
        quizzes: entry.value,
        lessonId: entry.key,
      );
    }
    localTimestamps[kQuizzes] =
        serverQuizzesTs?.millisecondsSinceEpoch;
  }

  // 5. تحديث الدروس (Lessons)
  final serverLessonsTs =
      serverTimestamps[kLessonsLastUpdated] as Timestamp?;
  final localLessonsTs = localTimestamps[kLessons];
  if (_isNewer(serverLessonsTs, localLessonsTs)) {
    final List<Map<String, dynamic>> rawData = await firestoreService
        .getData(path: BackendEndpoint.getLessons);
    final List<LessonModel> lessons = rawData
        .map((m) => LessonModel.fromJson(m))
        .toList();
    final lessonsLocal = getIt<LessonsLocalDataSource>();

    // تخزين كل Chapter مع دروسه
    final byChapter = <String, List<LessonModel>>{};
    for (final l in lessons) {
      byChapter.putIfAbsent(l.chapterId, () => []).add(l);
    }
    for (final entry in byChapter.entries) {
      await lessonsLocal.cacheLessons(
        lessons: entry.value,
        chapterId: entry.key,
        unitId: entry.key,
      );
    }

    localTimestamps[kLessons] =
        serverLessonsTs?.millisecondsSinceEpoch;
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
