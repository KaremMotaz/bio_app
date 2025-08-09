abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<dynamic> getData({required String path, String? documentId});

  Future<List<Map<String, dynamic>>> getFilteredData({
    required String path,
    String? field,
    dynamic value,
  });

  Future<List<Map<String, dynamic>>> fetchSubcollection({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    String? orderByField,
  });

  Future<List<Map<String, dynamic>>> fetchDoubleSubcollection({
    required String parentCollection,
    required String parentDocId,
    required String firstSubcollection,
    required String firstSubDocId,
    required String secondSubcollection,
    String? orderByField,
  });

  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  });
}
