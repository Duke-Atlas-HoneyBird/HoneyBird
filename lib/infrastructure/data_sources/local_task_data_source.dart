import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../models/drop_task_model.dart';

/// Abstract interface for local task data operations
abstract class LocalTaskDataSource {
  /// Retrieves all tasks from local storage
  Future<List<DropTaskModel>> getTasks();

  /// Creates a new task in local storage
  Future<DropTaskModel> createTask(DropTaskModel task);

  /// Updates an existing task in local storage
  Future<DropTaskModel> updateTask(DropTaskModel task);

  /// Deletes a task from local storage
  Future<void> deleteTask(String taskId);
}

/// Implementation of LocalTaskDataSource using SharedPreferences
class LocalTaskDataSourceImpl implements LocalTaskDataSource {
  final SharedPreferences sharedPreferences;

  LocalTaskDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<DropTaskModel>> getTasks() async {
    try {
      final jsonString = sharedPreferences.getString(StorageKeys.tasks);

      if (jsonString == null) {
        // Return empty list if no tasks exist yet
        return [];
      }

      final jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((jsonMap) => DropTaskModel.fromJson(jsonMap as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException('Failed to get tasks: $e');
    }
  }

  @override
  Future<DropTaskModel> createTask(DropTaskModel task) async {
    try {
      final tasks = await getTasks();
      tasks.add(task);
      await _saveTasks(tasks);
      return task;
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      }
      throw CacheException('Failed to create task: $e');
    }
  }

  @override
  Future<DropTaskModel> updateTask(DropTaskModel task) async {
    try {
      final tasks = await getTasks();
      final index = tasks.indexWhere((t) => t.id == task.id);

      if (index == -1) {
        throw CacheException('Task not found with ID: ${task.id}');
      }

      tasks[index] = task;
      await _saveTasks(tasks);
      return task;
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      }
      throw CacheException('Failed to update task: $e');
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      final tasks = await getTasks();
      tasks.removeWhere((task) => task.id == taskId);
      await _saveTasks(tasks);
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      }
      throw CacheException('Failed to delete task: $e');
    }
  }

  /// Helper method to save tasks list to local storage
  Future<void> _saveTasks(List<DropTaskModel> tasks) async {
    try {
      final jsonList = tasks.map((task) => task.toJson()).toList();
      final jsonString = json.encode(jsonList);
      
      final success = await sharedPreferences.setString(StorageKeys.tasks, jsonString);
      
      if (!success) {
        throw CacheException('Failed to save tasks to local storage');
      }
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      }
      throw CacheException('Failed to save tasks: $e');
    }
  }
}
