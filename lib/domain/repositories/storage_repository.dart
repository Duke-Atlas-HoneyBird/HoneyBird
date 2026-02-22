import 'dart:io';

/// Repository for uploading media files (images, videos) to cloud storage.
abstract class StorageRepository {
  Future<Uri> uploadPostImage(File file, String userId);
  Future<Uri> uploadPostVideo(File file, String userId);
}
