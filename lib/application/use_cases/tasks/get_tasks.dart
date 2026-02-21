import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/drop_task.dart';
import '../../../domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<Either<Failure, List<DropTask>>> call(String userUID) {
    return repository.getTasks(userUID);
  }
}
