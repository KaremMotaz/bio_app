import 'dart:developer';
import '../../features/chapters/data/data_source/chapters_remote_data_source.dart';
import '../../features/chapters/data/repos/chapter_repo_imp.dart';
import '../../features/lessons/data/data_source/lessons_remote_data_source.dart';
import '../../features/lessons/data/data_source/quizzes_remote_data_source.dart';
import '../../features/lessons/data/repos/lesson_repo_imp.dart';
import '../../features/lessons/data/repos/quiz_repo_imp.dart';
import '../../features/quiz_questions/data/data_source/quiz_questions_local_data_source.dart';
import '../../features/quiz_questions/data/data_source/quiz_questions_remote_data_source.dart';
import '../../features/quiz_questions/data/models/quiz_question_model.dart';
import '../../features/units/data/data_source/units_remote_data_source.dart';
import '../../features/units/data/repos/unit_repo_imp.dart';
import '../services/get_it_service.dart';
import '../../features/chapters/data/data_source/chapters_local_data_source.dart';
import '../../features/chapters/data/models/chapter_model.dart';
import '../../features/lessons/data/data_source/lessons_local_data_source.dart';
import '../../features/lessons/data/data_source/quizzes_local_data_source.dart';
import '../../features/units/data/data_source/units_local_data_source.dart';
import '../../features/units/data/models/unit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../../../core/helpers/constants.dart';

Future<void> fetchAndCacheData() async {
  final UnitsRemoteDataSource unitsRemoteDataSource =
      getIt<UnitsRemoteDataSource>();
  final ChaptersRemoteDataSource chaptersRemoteDataSource =
      getIt<ChaptersRemoteDataSource>();
  final LessonsRemoteDataSource lessonsRemoteDataSource =
      getIt<LessonsRemoteDataSource>();
  final QuizzesRemoteDataSource quizzesRemoteDataSource =
      getIt<QuizzesRemoteDataSource>();
  final QuizQuestionsRemoteDataSource quizQuestionsRemoteDataSource =
      getIt<QuizQuestionsRemoteDataSource>();
  final UnitRepoImpl unitRepoImpl = getIt<UnitRepoImpl>();
  final ChapterRepoImpl chapterRepoImpl = getIt<ChapterRepoImpl>();
  final LessonRepoImp lessonRepoImpl = getIt<LessonRepoImp>();
  final QuizRepoImp quizRepoImp = getIt<QuizRepoImp>();

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
    final List<UnitModel> units = (await unitsRemoteDataSource
        .getUnits());

    await getIt<UnitsLocalDataSource>().cacheUnits(units);
    localTimestamps[kUnits] = serverUnitsTs?.millisecondsSinceEpoch;
  }

  log("From units ${_isNewer(serverUnitsTs, localUnitsTs)}");

  // 4. تحديث الفصول (Chapters)
  final serverChaptersTs =
      serverTimestamps[kChaptersLastUpdated] as Timestamp?;
  final localChaptersTs = localTimestamps[kChapters];
  if (_isNewer(serverChaptersTs, localChaptersTs)) {
    final units = await unitRepoImpl.getUnits();
    final chaptersLocal = getIt<ChaptersLocalDataSource>();
    final allChapters = <ChapterModel>[];

    for (final unit in units.getOrElse(() => [])) {
      final chapters = await chaptersRemoteDataSource
          .getFilteredChapters(unitId: unit.id);

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
      final chapters = await chapterRepoImpl.getChapters(
        unitId: unit.id,
      );

      for (final chapter in chapters.getOrElse(() => [])) {
        final lessons = await lessonRepoImpl.getLessons(
          unitId: unit.id,
          chapterId: chapter.id,
        );

        for (final lesson in lessons.getOrElse(() => [])) {
          final lessonId = lesson.id;

          final quizzes = await quizzesRemoteDataSource
              .getFilteredQuizzes(lessonId: lessonId);

          await quizzesLocal.cacheQuizzes(
            quizzes: quizzes,
            lessonId: lessonId,
          );
        }
      }
    }

    localTimestamps[kQuizzes] =
        serverQuizzesTs?.millisecondsSinceEpoch;
  }

  // 6. تحديث الدروس (Lessons)
  final serverLessonsTs =
      serverTimestamps[kLessonsLastUpdated] as Timestamp?;
  final localLessonsTs = localTimestamps[kLessons];
  if (_isNewer(serverLessonsTs, localLessonsTs)) {
    final units = await unitRepoImpl.getUnits();
    final lessonsLocal = getIt<LessonsLocalDataSource>();

    for (final unit in units.getOrElse(() => [])) {
      final chapters = await chapterRepoImpl.getChapters(
        unitId: unit.id,
      );

      for (final chapter in chapters.getOrElse(() => [])) {
        final lessons = await lessonsRemoteDataSource
            .getFilteredLessons(
              unitId: unit.id,
              chapterId: chapter.id,
            );

        await lessonsLocal.cacheLessons(
          lessons: lessons,
          chapterId: chapter.id,
          unitId: unit.id,
        );
      }
    }

    localTimestamps[kLessons] =
        serverLessonsTs?.millisecondsSinceEpoch;
  }

  // 7. تحديث اسئلة الكويز (Quizzes Questions)
  final serverQuizzesQuestionsTs =
      serverTimestamps[kQuizzesQuestionsLastUpdated] as Timestamp?;
  final localQuizzesQuestionsTs = localTimestamps[kQuizQuestions];

  if (_isNewer(serverQuizzesQuestionsTs, localQuizzesQuestionsTs)) {
    final quizQuestionsLocal = getIt<QuizQuestionsLocalDataSource>();
    final allQuizQuestions = <QuizQuestionModel>[];

    final units = await unitRepoImpl.getUnits();

    for (final unit in units.getOrElse(() => [])) {
      final chapters = await chapterRepoImpl.getChapters(
        unitId: unit.id,
      );

      for (final chapter in chapters.getOrElse(() => [])) {
        final lessons = await lessonRepoImpl.getLessons(
          unitId: unit.id,
          chapterId: chapter.id,
        );

        for (final lesson in lessons.getOrElse(() => [])) {
          final quizzes = await quizRepoImp.getQuizzes(
            lessonId: lesson.id,
          );
          for (final quiz in quizzes.getOrElse(() => [])) {
            final quizQuestions = await quizQuestionsRemoteDataSource
                .getQuizQuestions(quizId: quiz.id);

            await quizQuestionsLocal.cacheQuizQuestions(
              quizQuestions: quizQuestions,
              quizId: quiz.id,
            );

            allQuizQuestions.addAll(quizQuestions);
          }
        }
      }
    }

    localTimestamps[kQuizQuestions] =
        serverChaptersTs?.millisecondsSinceEpoch;
  }

  // 7. حفظ التوقيتات المحدثة
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
