import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';

/// Uploads post media (images/videos) to Firebase Storage and returns download URLs.
abstract class FirebaseStorageDataSource {
  Future<Uri> uploadPostImage(File file, String userId);
  Future<Uri> uploadPostVideo(File file, String userId);
}

class FirebaseStorageDataSourceImpl implements FirebaseStorageDataSource {
  final FirebaseStorage _storage;

  FirebaseStorageDataSourceImpl({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  @override
  Future<Uri> uploadPostImage(File file, String userId) async {
    try {
      final ref = _storage
          .ref()
          .child(FirebaseStoragePaths.postImages)
          .child(userId)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return Uri.parse(url);
    } catch (e) {
      throw ServerException('Failed to upload image: $e');
    }
  }

  @override
  Future<Uri> uploadPostVideo(File file, String userId) async {
    try {
      final ref = _storage
          .ref()
          .child(FirebaseStoragePaths.postVideos)
          .child(userId)
          .child('${DateTime.now().millisecondsSinceEpoch}.mp4');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return Uri.parse(url);
    } catch (e) {
      throw ServerException('Failed to upload video: $e');
    }
  }
}
