import 'package:cloud_firestore/cloud_firestore.dart';

import 'data_service.dart';

class FirestoreService implements DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await firestore.doc(path).update(data);
  }

  @override
  Future<void> deleteData({required String path}) async {
    final segments = path.split('/');

    if (segments.length.isOdd) {
      // path → collection
      final snapshot = await firestore.collection(path).get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } else {
      // path → document
      await firestore.doc(path).delete();
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    List<FilterCondition>? filters,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) async {
    final segments = path.split('/');
    if (segments.length.isOdd) {
      // collection
      Query<Map<String, dynamic>> query = firestore.collection(path);

      // Apply filters
      if (filters != null) {
        for (final f in filters) {
          query = query.where(f.field, isEqualTo: f.value);
        }
      }

      // order & limit
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }
      if (limit != null) query = query.limit(limit);

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => {"id": doc.id, ...doc.data()})
          .toList();
    } else {
      // document
      final doc = await firestore.doc(path).get();
      return doc.exists ? {"id": doc.id, ...?doc.data()} : null;
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection({
    required String path,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) {
    Query<Map<String, dynamic>> query = firestore.collection(path);

    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }
    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots();
  }

  @override
  Future<bool> checkIfDataExists({required String path}) async {
    final segments = path.split('/');
    if (segments.length.isOdd) {
      final snapshot = await firestore
          .collection(path)
          .limit(1)
          .get();
      return snapshot.docs.isNotEmpty;
    } else {
      final doc = await firestore.doc(path).get();
      return doc.exists;
    }
  }
}

class FilterCondition {
  final String field;
  final dynamic value;

  FilterCondition(this.field, this.value);
}
