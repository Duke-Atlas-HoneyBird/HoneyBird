import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/drop_task.dart';
import '../../../domain/repositories/task_repository.dart';

class CreateTask {
  final TaskRepository repository;

  CreateTask(this.repository);

  Future<Either<Failure, DropTask>> call(DropTask task) {
    return repository.createTask(task);
  }
}
