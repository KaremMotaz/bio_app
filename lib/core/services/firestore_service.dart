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
Future<void> editFields({
  required String collectionName,
  required String docId,
  required Map<String, dynamic> fields,
}) async {
  await firestore.collection(collectionName).doc(docId).update(fields);
}

  @override
  Future<void> addToSubcollection({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required Map<String, dynamic> data,
  }) {
    final docRef = FirebaseFirestore.instance
        .collection(parentCollection)
        .doc(parentDocId)
        .collection(subCollection)
        .doc();

    return docRef.set(data);
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? documentId,
  }) async {
    if (documentId != null) {
      DocumentSnapshot<Map<String, dynamic>> data = await firestore
          .collection(path)
          .doc(documentId)
          .get();
      return {...?data.data(), 'id': data.id};
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
    Query<Map<String, dynamic>> query = firestore
        .collection(parentCollection)
        .doc(parentDocId)
        .collection(subCollection);

    if (orderByField != null) {
      query = query.orderBy(orderByField);
    }

    final snap = await query.get();
    return snap.docs.map((d) => {...d.data(), 'id': d.id}).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> fetchDoubleSubcollection({
    required String parentCollection,
    required String parentDocId,
    required String firstSubcollection,
    required String firstSubDocId,
    required String secondSubcollection,
    String? orderByField,
  }) async {
    Query<Map<String, dynamic>> query = firestore
        .collection(parentCollection)
        .doc(parentDocId)
        .collection(firstSubcollection)
        .doc(firstSubDocId)
        .collection(secondSubcollection);

    if (orderByField != null) {
      query = query.orderBy(orderByField);
    }

    final snap = await query.get();
    return snap.docs
        .map((doc) => {...doc.data(), 'id': doc.id})
        .toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getFilteredData({
    required String path,
    String? field,
    dynamic value,
  }) async {
    Query<Map<String, dynamic>> query = firestore.collection(path);

    if (field != null && value != null) {
      query = query.where(field, isEqualTo: value);
    }

    final snap = await query.get();
    return snap.docs
        .map((doc) => {...doc.data(), 'id': doc.id})
        .toList();
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

  // @override
  // Future<void> uploadScoreToLeaderboards({
  //   required double score,
  // }) async {
  //   final batch = firestore.batch();
  //   final userId = FirebaseAuthService.userId;

  //   final allTimeRef = firestore
  //       .collection("leaderboards")
  //       .doc("top10_all_time");
  //   final monthRef = firestore
  //       .collection("leaderboards")
  //       .doc("top10_month");
  //   final weekRef = firestore
  //       .collection("leaderboards")
  //       .doc("top10_week");

  //   final userBaseData = {
  //     "id": userId,
  //     "fullName": {getUser().firstName, getUser().lastName}.join(" "),
  //     "imageUrl": getUser().imageUrl,
  //     "avatarColor": getUser().avatarColor,
  //   };

  //   void updateLeaderboard(DocumentReference ref) {
  //     batch.set(ref, {
  //       userId: {
  //         ...userBaseData,
  //         "score": FieldValue.increment(score),
  //       },
  //     }, SetOptions(merge: true));
  //   }

  //   updateLeaderboard(allTimeRef);
  //   updateLeaderboard(monthRef);
  //   updateLeaderboard(weekRef);

  //   await batch.commit();
  // }
}
