import 'firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  });

  Future<void> deleteData({required String path});

  /// Unified fetch for both document & collection
  Future<dynamic> getData({
    required String path,
    List<FilterCondition>? filters,
    String? orderBy,
    bool descending = false,
    int? limit,
  });

  /// Unified real-time stream for both doc & collection
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection({
    required String path,
    String? orderBy,
    bool descending = false,
    int? limit,
  });
  
  Future<bool> checkIfDataExists({required String path});
}
