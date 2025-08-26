import 'dart:developer';
import 'package:bio_app/features/exam/data/datasources/exams_local_data_source.dart';
import 'package:bio_app/features/exam/data/models/exam_model.dart';
import 'package:bio_app/features/exam/data/repos/exam_repo_impl.dart';
import 'package:bio_app/features/exam/domain/entities/exam_entity.dart';
import '../services/get_it_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../../../core/helpers/constants.dart';

Future<void> fetchAndCacheExamData() async {
  final examRepoImpl = getIt<ExamRepoImpl>();

  // 1. قراءة التوقيتات من السيرفر
  final lastUpdatesDoc = await FirebaseFirestore.instance
      .collection('metadata')
      .doc('last_updates')
      .get();

  final serverTimestamps = lastUpdatesDoc.data() ?? {};
  log('Server timestamps: $serverTimestamps');

  // 2. قراءة التوقيتات المحلية من Hive
  final hiveBox = Hive.box(kAppCacheBox);
  final localTimestamps = Map<String, dynamic>.from(
    hiveBox.get(kLastUpdatedTimestampsKey, defaultValue: {}),
  );
  log('Local timestamps: $localTimestamps');

  // 3. تحديث الإمتحانات (Exams)
  final Timestamp? serverExamsTs =
      serverTimestamps[kExamsLastUpdated] as Timestamp?;

  final localExamsTs = localTimestamps[kExams];

  if (_isNewer(serverExamsTs, localExamsTs)) {
    final List<ExamEntity> examEntities =
        (await examRepoImpl.getExams()).getOrElse(() => []);

    final List<ExamModel> exams = examEntities
        .map((entity) => ExamModel.fromEntity(entity))
        .toList();

    await getIt<ExamsLocalDataSource>().cacheExams(exams);

    // حفظ التوقيت الجديد بالملي ثانية
    localTimestamps[kExams] = serverExamsTs?.millisecondsSinceEpoch;
    log('Exams updated from server.');
  } else {
    log('Exams are up to date.');
  }

  // 4. حفظ التوقيتات المحدثة
  await hiveBox.put(kLastUpdatedTimestampsKey, localTimestamps);
}

/// مقارنة توقيت السيرفر مع التوقيت المحلي
bool _isNewer(Timestamp? server, dynamic local) {
  if (server == null) return false;
  final serverMs = server.millisecondsSinceEpoch;

  if (local == null) return true;
  if (local is int) return serverMs > local;
  if (local is Timestamp) return serverMs > local.millisecondsSinceEpoch;

  return true;
}
