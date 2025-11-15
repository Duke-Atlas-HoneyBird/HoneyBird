import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/drop_task.dart';
import '../../domain/repositories/task_repository.dart';
import '../data_sources/local_task_data_source.dart';
import '../models/drop_task_model.dart';

/// Implementation of TaskRepository that uses local storage as the data source
class TaskRepositoryImpl implements TaskRepository {
  final LocalTaskDataSource dataSource;

  TaskRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<DropTask>>> getTasks() async {
    try {
      final taskModels = await dataSource.getTasks();
      return Right(taskModels);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, DropTask>> createTask(DropTask task) async {
    try {
      final taskModel = DropTaskModel.fromEntity(task);
      final createdTask = await dataSource.createTask(taskModel);
      return Right(createdTask);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, DropTask>> updateTask(DropTask task) async {
    try {
      final taskModel = DropTaskModel.fromEntity(task);
      final updatedTask = await dataSource.updateTask(taskModel);
      return Right(updatedTask);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String taskId) async {
    try {
      await dataSource.deleteTask(taskId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error occurred: $e'));
    }
  }
}
