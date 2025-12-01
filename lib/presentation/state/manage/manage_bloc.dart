import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/drop_task.dart';
import '../../../domain/entities/drop_status.dart';
import 'manage_event.dart';
import 'manage_state.dart';

/// Bloc for managing tasks state and business logic
class ManageBloc extends Bloc<ManageEvent, ManageState> {
  final _uuid = const Uuid();

  ManageBloc() : super(const ManageInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTaskStatus>(_onUpdateTaskStatus);
    on<DeleteTask>(_onDeleteTask);
    on<RefreshTasks>(_onRefreshTasks);
  }

  /// Generate dummy tasks
  List<DropTask> _generateDummyTasks() {
    return [
      const DropTask(
        id: 'task_1',
        title: 'Review restaurant recommendations',
        status: DropStatus.todo,
      ),
      const DropTask(
        id: 'task_2',
        title: 'Update user preferences',
        status: DropStatus.working,
      ),
      const DropTask(
        id: 'task_3',
        title: 'Plan weekend wine tasting trip',
        status: DropStatus.todo,
      ),
      const DropTask(
        id: 'task_4',
        title: 'Complete profile setup',
        status: DropStatus.completed,
      ),
      const DropTask(
        id: 'task_5',
        title: 'Explore new Italian restaurants',
        status: DropStatus.working,
      ),
      const DropTask(
        id: 'task_6',
        title: 'Share favorite dining experience',
        status: DropStatus.todo,
      ),
    ];
  }

  Future<void> _onLoadTasks(
    LoadTasks event,
    Emitter<ManageState> emit,
  ) async {
    emit(const ManageLoading());
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      final tasks = _generateDummyTasks();
      emit(ManageLoaded(tasks: tasks));
    } catch (e) {
      emit(ManageError('Failed to load tasks: ${e.toString()}'));
    }
  }

  Future<void> _onAddTask(
    AddTask event,
    Emitter<ManageState> emit,
  ) async {
    final currentState = state;
    if (currentState is ManageLoaded) {
      final newTask = DropTask(
        id: _uuid.v4(),
        title: event.title,
        status: DropStatus.todo,
      );
      
      final updatedTasks = [newTask, ...currentState.tasks];
      emit(ManageLoaded(tasks: updatedTasks));
    }
  }

  Future<void> _onUpdateTaskStatus(
    UpdateTaskStatus event,
    Emitter<ManageState> emit,
  ) async {
    final currentState = state;
    if (currentState is ManageLoaded) {
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
      
      final updatedTasks = currentState.tasks.map((task) {
        if (task.id == event.taskId) {
          return DropTask(
            id: task.id,
            title: task.title,
            status: newStatus,
          );
        }
        return task;
      }).toList();
      
      emit(ManageLoaded(tasks: updatedTasks));
    }
  }

  Future<void> _onDeleteTask(
    DeleteTask event,
    Emitter<ManageState> emit,
  ) async {
    final currentState = state;
    if (currentState is ManageLoaded) {
      final updatedTasks = currentState.tasks
          .where((task) => task.id != event.taskId)
          .toList();
      
      emit(ManageLoaded(tasks: updatedTasks));
    }
  }

  Future<void> _onRefreshTasks(
    RefreshTasks event,
    Emitter<ManageState> emit,
  ) async {
    final currentState = state;
    if (currentState is ManageLoaded) {
      // Keep current tasks while refreshing
      emit(ManageLoaded(tasks: currentState.tasks));
    }
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    try {
      final tasks = _generateDummyTasks();
      emit(ManageLoaded(tasks: tasks));
    } catch (e) {
      emit(ManageError('Failed to refresh tasks: ${e.toString()}'));
    }
  }
}

