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
}
