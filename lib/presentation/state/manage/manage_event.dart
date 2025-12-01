import 'package:equatable/equatable.dart';

/// Base class for Manage events
abstract class ManageEvent extends Equatable {
  const ManageEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load tasks
class LoadTasks extends ManageEvent {
  const LoadTasks();
}

/// Event to add a new task
class AddTask extends ManageEvent {
  final String title;

  const AddTask(this.title);

  @override
  List<Object?> get props => [title];
}

/// Event to update task status
class UpdateTaskStatus extends ManageEvent {
  final String taskId;
  final String status; // 'todo', 'working', 'completed'

  const UpdateTaskStatus({
    required this.taskId,
    required this.status,
  });

  @override
  List<Object?> get props => [taskId, status];
}

/// Event to delete a task
class DeleteTask extends ManageEvent {
  final String taskId;

  const DeleteTask(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

/// Event to refresh tasks
class RefreshTasks extends ManageEvent {
  const RefreshTasks();
}

