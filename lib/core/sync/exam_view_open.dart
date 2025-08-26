import 'package:bio_app/core/sync/fetch_and_cache_exam_data.dart';

class ExamViewOpen {
  ExamViewOpen._internal();
  static final ExamViewOpen instance = ExamViewOpen._internal();

  bool _hasRun = false;

  Future<void> runOnce() async {
    if (_hasRun) return;
    _hasRun = true;

    await fetchAndCacheExamData();
  }
}
