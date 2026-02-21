import 'package:dartz/dartz.dart';
import '../entities/drop_task.dart';
import '../../core/error/failures.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<DropTask>>> getTasks(String userUID);
  Future<Either<Failure, DropTask>> createTask(DropTask task);
  Future<Either<Failure, DropTask>> updateTask(DropTask task);
  Future<Either<Failure, void>> deleteTask(String taskId);
}
