abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<dynamic> getData({required String path, String? documentId});

  Future<List<Map<String, dynamic>>> getFilteredData({
    required String path,
    required String field,
    required dynamic isEqualToValue,
  });

  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  });
}
