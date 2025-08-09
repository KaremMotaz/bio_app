import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<dynamic> getData({required String path, String? documentId});

  Future<List<T>> getFilteredData<T>({
    required String path,
    String? field,
    dynamic value,
    required T Function(DocumentSnapshot<Map<String, dynamic>> doc)
    fromDocument,
  });

  Future<List<Map<String, dynamic>>> fetchSubcollection({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    String? orderByField,
  });

  Future<List<T>> fetchDoubleSubcollection<T>({
    required String parentCollection,
    required String parentDocId,
    required String firstSubcollection,
    required String firstSubDocId,
    required String secondSubcollection,
    String? orderByField,
    required T Function(DocumentSnapshot<Map<String, dynamic>> doc)
    fromDocument,
  });

  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  });
}
