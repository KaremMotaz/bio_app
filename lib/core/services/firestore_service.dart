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
      return data.docs.map((doc) {
        return {...doc.data(), 'id': doc.id};
      }).toList();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchSubcollection({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    String? orderByField,
  }) async {
    CollectionReference<Map<String, dynamic>> subColRef = firestore
        .collection(parentCollection)
        .doc(parentDocId)
        .collection(subCollection);

    // Add orderBy if needed
    Query<Map<String, dynamic>> query = orderByField != null
        ? subColRef.orderBy(orderByField)
        : subColRef;

    // تنفيذ الجلب
    final snap = await query.get();

    // Add id to each document and return the list of documents with id
    return snap.docs.map((d) => {...d.data(), 'id': d.id}).toList();
  }

  @override
  Future<List<T>> fetchDoubleSubcollection<T>({
    required String parentCollection,
    required String parentDocId,
    required String firstSubcollection,
    required String firstSubDocId,
    required String secondSubcollection,
    String? orderByField,
    required T Function(DocumentSnapshot<Map<String, dynamic>> doc)
    fromDocument,
  }) async {
    CollectionReference<Map<String, dynamic>> subColRef = firestore
        .collection(parentCollection)
        .doc(parentDocId)
        .collection(firstSubcollection)
        .doc(firstSubDocId)
        .collection(secondSubcollection);

    Query<Map<String, dynamic>> query = subColRef;

    if (orderByField != null) {
      query = query.orderBy(orderByField);
    }

    final snap = await query.get();
    return snap.docs.map((doc) => fromDocument(doc)).toList();
  }

  @override
  Future<List<T>> getFilteredData<T>({
    required String path,
    String? field,
    dynamic value,
    required T Function(DocumentSnapshot<Map<String, dynamic>> doc)
    fromDocument,
  }) async {
    Query<Map<String, dynamic>> query = firestore.collection(path);

    if (field != null && value != null) {
      query = query.where(field, isEqualTo: value);
    }

    final snapshot = await query.get();

    return snapshot.docs.map((doc) => fromDocument(doc)).toList();
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
