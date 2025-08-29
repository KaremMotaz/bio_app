import 'dart:io';

abstract class StorageService {
  Future<File> uploadFile({
    required File file,
    required String path,
    String? uid,
  });
  Future<String> getImage({
    required File file,
    required String path,
    String? uid,
  });
  Future<void> deleteImageFromStorage({
    required String bucket,
    required String filePath,
  });
}
