import 'package:equatable/equatable.dart';

/// Base class for Manage events
abstract class ManageEvent extends Equatable {
  const ManageEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load tasks
class LoadTasks extends ManageEvent {
  final String userUID;
  const LoadTasks(this.userUID);

  @override
  List<Object?> get props => [userUID];
}

/// Event to add a new task
class AddTask extends ManageEvent {
  final String title;
  final String userUID;

  const AddTask({required this.title, required this.userUID});

  @override
  List<Object?> get props => [title, userUID];
}

/// Event to update task status
class UpdateTaskStatus extends ManageEvent {
  final String taskId;
  final String status; // 'todo', 'working', 'completed'
  final String userUID;

  const UpdateTaskStatus({
    required this.taskId,
    required this.status,
    required this.userUID,
  });

  @override
  List<Object?> get props => [taskId, status, userUID];
}

/// Event to delete a task
class DeleteTask extends ManageEvent {
  final String taskId;
  final String userUID;

  const DeleteTask({required this.taskId, required this.userUID});

  @override
  List<Object?> get props => [taskId, userUID];
}

/// Event to refresh tasks
class RefreshTasks extends ManageEvent {
  final String userUID;
  const RefreshTasks(this.userUID);

  @override
  List<Object?> get props => [userUID];
}

