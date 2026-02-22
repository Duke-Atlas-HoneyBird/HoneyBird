import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/drop_task.dart';
import '../../../domain/entities/drop_status.dart';
import 'manage_event.dart';
import 'manage_state.dart';
import '../../../application/use_cases/tasks/create_task.dart' as uc;
import '../../../application/use_cases/tasks/delete_task.dart' as uc;
import '../../../application/use_cases/tasks/get_tasks.dart' as uc;
import '../../../application/use_cases/tasks/update_task.dart' as uc;

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
  }) : super(const ManageState()) {
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
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await getTasks(event.userUID);
    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: failure.message, tasks: [])),
      (tasks) => emit(state.copyWith(isLoading: false, tasks: tasks)),
    );
  }

  Future<void> _onAddTask(
    AddTask event,
    Emitter<ManageState> emit,
  ) async {
    final task = DropTask(
      title: event.title,
      status: DropStatus.todo,
      userUID: event.userUID,
    );

    final result = await createTask(task);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (createdTask) => emit(state.copyWith(
          tasks: [createdTask, ...state.tasks])),
    );
  }

  Future<void> _onUpdateTaskStatus(
    UpdateTaskStatus event,
    Emitter<ManageState> emit,
  ) async {
    final taskIndex = state.tasks.indexWhere((t) => t.id == event.taskId);
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
      title: state.tasks[taskIndex].title,
      status: newStatus,
      userUID: event.userUID,
    );

    final result = await updateTask(updatedTask);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (updated) {
        final updatedTasks = state.tasks
            .map((task) => task.id == event.taskId ? updated : task)
            .toList();
        emit(state.copyWith(tasks: updatedTasks));
      },
    );
  }

  Future<void> _onDeleteTask(
    DeleteTask event,
    Emitter<ManageState> emit,
  ) async {
    final result = await deleteTask(event.taskId);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) => emit(state.copyWith(
          tasks: state.tasks.where((t) => t.id != event.taskId).toList())),
    );
  }

  Future<void> _onRefreshTasks(
    RefreshTasks event,
    Emitter<ManageState> emit,
  ) async {
    final result = await getTasks(event.userUID);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (tasks) => emit(state.copyWith(tasks: tasks)),
    );
  }
}
