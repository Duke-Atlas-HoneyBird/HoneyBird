import 'package:freezed_annotation/freezed_annotation.dart';

part 'manage_event.freezed.dart';

@freezed
class ManageEvent with _$ManageEvent {
  const factory ManageEvent.loadTasks(String userUID) = LoadTasks;
  const factory ManageEvent.addTask({
    required String title,
    required String userUID,
  }) = AddTask;
  const factory ManageEvent.updateTaskStatus({
    required String taskId,
    required String status,
    required String userUID,
  }) = UpdateTaskStatus;
  const factory ManageEvent.deleteTask({
    required String taskId,
    required String userUID,
  }) = DeleteTask;
  const factory ManageEvent.refreshTasks(String userUID) = RefreshTasks;
}
