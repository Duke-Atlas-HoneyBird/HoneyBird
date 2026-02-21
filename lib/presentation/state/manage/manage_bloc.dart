import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/drop_task.dart';
import '../../../domain/entities/drop_status.dart';
import 'manage_event.dart';
import 'manage_state.dart';
import '../../../application/use_cases/tasks/create_task.dart' as uc;
import '../../../application/use_cases/tasks/delete_task.dart' as uc;
import '../../../application/use_cases/tasks/get_tasks.dart' as uc;
import '../../../application/use_cases/tasks/update_task.dart' as uc;

/// Bloc for managing tasks state and business logic
class ManageBloc extends Bloc<ManageEvent, ManageState> {
  final uc.GetTasks getTasks;
  final uc.CreateTask createTask;
  final uc.UpdateTask updateTask;
  final uc.DeleteTask deleteTask;

  ManageBloc({
    required this.getTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(const ManageInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTaskStatus>(_onUpdateTaskStatus);
    on<DeleteTask>(_onDeleteTask);
    on<RefreshTasks>(_onRefreshTasks);
  }

  Future<void> _onLoadTasks(
    LoadTasks event,
    Emitter<ManageState> emit,
  ) async {
    emit(const ManageLoading());
    final result = await getTasks(event.userUID);
    result.fold(
      (failure) => emit(ManageError(failure.message)),
      (tasks) => emit(ManageLoaded(tasks: tasks)),
    );
  }

  Future<void> _onAddTask(
    AddTask event,
    Emitter<ManageState> emit,
  ) async {
    final currentState = state;
    if (currentState is ManageLoaded) {
      final task = DropTask(
        title: event.title,
        status: DropStatus.todo,
        userUID: event.userUID,
      );
      
      final result = await createTask(task);
      result.fold(
        (failure) => emit(ManageError(failure.message)),
        (createdTask) {
          final updatedTasks = [createdTask, ...currentState.tasks];
          emit(ManageLoaded(tasks: updatedTasks));
        },
      );
    }
  }

  Future<void> _onUpdateTaskStatus(
    UpdateTaskStatus event,
    Emitter<ManageState> emit,
  ) async {
    final currentState = state;
    if (currentState is ManageLoaded) {
      final taskIndex = currentState.tasks.indexWhere((t) => t.id == event.taskId);
      if (taskIndex == -1) return;

      DropStatus newStatus;
      switch (event.status) {
        case 'working':
          newStatus = DropStatus.working;
          break;
        case 'completed':
          newStatus = DropStatus.completed;
          break;
        default:
          newStatus = DropStatus.todo;
      }
      
      final updatedTask = DropTask(
        id: event.taskId,
        title: currentState.tasks[taskIndex].title,
        status: newStatus,
        userUID: event.userUID,
      );

      final result = await updateTask(updatedTask);
      result.fold(
        (failure) => emit(ManageError(failure.message)),
        (updated) {
          final updatedTasks = currentState.tasks.map((task) {
            return task.id == event.taskId ? updated : task;
          }).toList();
          emit(ManageLoaded(tasks: updatedTasks));
        },
      );
    }
  }

  Future<void> _onDeleteTask(
    DeleteTask event,
    Emitter<ManageState> emit,
  ) async {
    final currentState = state;
    if (currentState is ManageLoaded) {
      final result = await deleteTask(event.taskId);
      result.fold(
        (failure) => emit(ManageError(failure.message)),
        (_) {
          final updatedTasks = currentState.tasks
              .where((task) => task.id != event.taskId)
              .toList();
          emit(ManageLoaded(tasks: updatedTasks));
        },
      );
    }
  }

  Future<void> _onRefreshTasks(
    RefreshTasks event,
    Emitter<ManageState> emit,
  ) async {
    final result = await getTasks(event.userUID);
    result.fold(
      (failure) => emit(ManageError(failure.message)),
      (tasks) => emit(ManageLoaded(tasks: tasks)),
    );
  }
}

