import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

Future<void> syncLocalScoreToFirestore(String studentId) async {
  final box = Hive.box('scores');
  final local = box.get(studentId);
  if (local == null) return;
  if (!local['dirty']) return; // لا يوجد تغيير، لا تكتب

  final docRef = FirebaseFirestore.instance.collection('students').doc(studentId);

  // نستخدم update أو set(merge:true) بحيث نكتب أقل حقول ممكنة
  await docRef.set({
    'totalScore': local['totalScore'],
    'lastUpdated': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));

  // بعد الكتابة نعلم الـ Hive أن الـ doc تم مزامنته
  box.put(studentId, {
    ...local,
    'dirty': false,
    'lastSyncedAt': DateTime.now().toIso8601String(),
  });
}


Future<void> recomputeAndWriteLeaderboardTop10() async {
  final q = await FirebaseFirestore.instance
    .collection('students')
    .orderBy('totalScore', descending: true)
    .limit(10)
    .get();

  final entries = q.docs.map((d) => {
    'id': d.id,
    'name': d['name'] ?? '',
    'score': d['totalScore'] ?? 0,
  }).toList();

  await FirebaseFirestore.instance
    .collection('leaderboard')
    .doc('top10')
    .set({
      'entries': entries,
      'updatedAt': FieldValue.serverTimestamp(),
    });
}
Future<List<Map<String, dynamic>>> getLeaderboardCached() async {
  final box = Hive.box('cache');
  final cache = box.get('leaderboard_top10');
  if (cache != null) {
    final updatedAt = DateTime.parse(cache['updatedAt']);
    if (DateTime.now().difference(updatedAt) < const Duration(hours: 2)) {
      return List<Map<String,dynamic>>.from(cache['entries']);
    }
  }

  // غير موجود أو قديم -> نقرؤه من Firestore مرة واحدة
  final doc = await FirebaseFirestore.instance.collection('leaderboard').doc('top10').get();
  if (doc.exists) {
    final entries = List<Map<String,dynamic>>.from(doc['entries']);
    box.put('leaderboard_top10', {
      'entries': entries,
      'updatedAt': DateTime.now().toIso8601String(),
    });
    return entries;
  }
  return [];
}
