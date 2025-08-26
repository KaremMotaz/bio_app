import 'dart:developer';
import 'package:bio_app/features/exam/data/datasources/exam_remote_data_source.dart';
import 'package:bio_app/features/exam/data/datasources/exams_local_data_source.dart';
import 'package:bio_app/features/exam/data/models/exam_model.dart';
import '../services/get_it_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../../../core/helpers/constants.dart';

Future<void> fetchAndCacheExamData() async {
  final examsRemoteDataSource = getIt<ExamsRemoteDataSource>();

  // 1. قراءة التوقيتات من السيرفر
  final lastUpdatesDoc = await FirebaseFirestore.instance
      .collection('metadata')
      .doc('last_updates')
      .get();

  final Map<String, dynamic> serverTimestamps =
      lastUpdatesDoc.data() ?? {};

  // 2. قراءة التوقيتات المحلية من Hive
  final hiveBox = Hive.box(kAppCacheBox);
  final Map<String, dynamic> localTimestamps =
      Map<String, dynamic>.from(
        hiveBox.get(kLastUpdatedTimestampsKey, defaultValue: {}),
      );

  // 3. تحديث الإمتحانات (Exams)
  final Timestamp? serverExamsTs =
      serverTimestamps[kExamsLastUpdated] as Timestamp?;

  final localExamsTs = localTimestamps[kExams];

  if (_isNewer(serverExamsTs, localExamsTs)) {
    final List<ExamModel> exams = (await examsRemoteDataSource
        .getExams());

    await getIt<ExamsLocalDataSource>().cacheExams(exams);

    // حفظ التوقيت الجديد بالملي ثانية
    localTimestamps[kExams] = serverExamsTs?.millisecondsSinceEpoch;
  }

  // 4. حفظ التوقيتات المحدثة
  await hiveBox.put(kLastUpdatedTimestampsKey, localTimestamps);
  log("From exams ${_isNewer(serverExamsTs, localExamsTs)}");
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
