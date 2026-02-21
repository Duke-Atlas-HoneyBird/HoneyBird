import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../models/drop_task_model.dart';

/// Abstract interface for Firebase task data operations
abstract class FirebaseTaskDataSource {
  /// Retrieves tasks for a specific user from Firestore
  Future<List<DropTaskModel>> getTasks(String userUID);

  /// Creates a new task in Firestore
  Future<DropTaskModel> createTask(DropTaskModel task);

  /// Updates an existing task in Firestore
  Future<DropTaskModel> updateTask(DropTaskModel task);

  /// Deletes a task from Firestore
  Future<void> deleteTask(String taskId);
}

/// Implementation of FirebaseTaskDataSource using Cloud Firestore
class FirebaseTaskDataSourceImpl implements FirebaseTaskDataSource {
  final FirebaseFirestore firestore;

  FirebaseTaskDataSourceImpl({required this.firestore});

  CollectionReference get _collection => firestore.collection(FirebaseCollections.tasks);

  @override
  Future<List<DropTaskModel>> getTasks(String userUID) async {
    try {
      final snapshot = await _collection
          .where('userUID', isEqualTo: userUID)
          .get();

      return snapshot.docs
          .map((doc) => DropTaskModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException('Failed to get tasks from Firestore: $e');
    }
  }

  @override
  Future<DropTaskModel> createTask(DropTaskModel task) async {
    try {
      await _collection.doc(task.id).set(task.toJson());
      return task;
    } catch (e) {
      throw ServerException('Failed to create task in Firestore: $e');
    }
  }

  @override
  Future<DropTaskModel> updateTask(DropTaskModel task) async {
    try {
      await _collection.doc(task.id).update(task.toJson());
      return task;
    } catch (e) {
      throw ServerException('Failed to update task in Firestore: $e');
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await _collection.doc(taskId).delete();
    } catch (e) {
      throw ServerException('Failed to delete task from Firestore: $e');
    }
  }
}
