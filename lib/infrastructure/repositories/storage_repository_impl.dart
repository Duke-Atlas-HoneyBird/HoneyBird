import 'dart:io';
import '../../domain/repositories/storage_repository.dart';
import '../data_sources/firebase_storage_data_source.dart';

/// Implementation of StorageRepository using Firebase Storage.
class StorageRepositoryImpl implements StorageRepository {
  final FirebaseStorageDataSource _dataSource;

  StorageRepositoryImpl({required FirebaseStorageDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Uri> uploadPostImage(File file, String userId) =>
      _dataSource.uploadPostImage(file, userId);

  @override
  Future<Uri> uploadPostVideo(File file, String userId) =>
      _dataSource.uploadPostVideo(file, userId);
}
