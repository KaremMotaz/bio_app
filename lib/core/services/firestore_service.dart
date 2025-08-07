import 'package:cloud_firestore/cloud_firestore.dart';

import 'data_service.dart';

class FirestoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      await firestore.collection(path).doc(documentId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future getData({required String path, String? documentId}) async {
    if (documentId != null) {
      DocumentSnapshot<Map<String, dynamic>> data = await firestore
          .collection(path)
          .doc(documentId)
          .get();
      return data.data();
    } else {
      QuerySnapshot<Map<String, dynamic>> data = await firestore
          .collection(path)
          .get();
      return data.docs.map((e) {
        return e.data();
      }).toList();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getFilteredData({
    required String path,
    String? field1,
    dynamic value1,
    String? field2,
    dynamic value2,
  }) async {
    Query<Map<String, dynamic>> query = firestore.collection(path);

    if (field1 != null && value1 != null) {
      query = query.where(field1, isEqualTo: value1);
    }

    if (field2 != null && value2 != null) {
      query = query.where(field2, isEqualTo: value2);
    }

    QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> data = await firestore
        .collection(path)
        .doc(documentId)
        .get();
    return data.exists;
  }

  // // 🔹 جديد 1: أجيب أحدث تاريخ تحديث (قراءة واحدة فقط)
  // Future<DateTime?> getLatestUpdatedAt(String path) async {
  //   final q = await firestore
  //       .collection(path)
  //       .orderBy('lastUpdated', descending: true)
  //       .limit(1)
  //       .get();
  //   if (q.docs.isEmpty) return null;
  //   final ts = q.docs.first.data()['lastUpdated'] as Timestamp?;
  //   return ts?.toDate().toUtc();
  // }
}
