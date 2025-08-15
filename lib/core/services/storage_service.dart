import 'dart:io';

abstract class StorageService {
  Future<File> uploadFile(File file, String path);
  Future<String> getImage(File file, String path);
  Future<void> deleteImageFromStorage({
    required String bucket,
    required String filePath,
  });
}
