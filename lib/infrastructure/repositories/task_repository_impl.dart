import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/drop_task.dart';
import '../../domain/repositories/task_repository.dart';
import '../data_sources/firebase_task_data_source.dart';
import '../models/drop_task_model.dart';

/// Implementation of TaskRepository that uses Firestore as the data source
class TaskRepositoryImpl implements TaskRepository {
  final FirebaseTaskDataSource dataSource;

  TaskRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<DropTask>>> getTasks(String userUID) async {
    try {
      final taskModels = await dataSource.getTasks(userUID);
      return Right(taskModels);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, DropTask>> createTask(DropTask task) async {
    try {
      final taskModel = DropTaskModel.fromEntity(task);
      final createdTask = await dataSource.createTask(taskModel);
      return Right(createdTask);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, DropTask>> updateTask(DropTask task) async {
    try {
      final taskModel = DropTaskModel.fromEntity(task);
      final updatedTask = await dataSource.updateTask(taskModel);
      return Right(updatedTask);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String taskId) async {
    try {
      await dataSource.deleteTask(taskId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: $e'));
    }
  }
}
