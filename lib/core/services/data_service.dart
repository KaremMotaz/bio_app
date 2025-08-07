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

  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  });
}
