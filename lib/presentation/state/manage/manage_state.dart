import 'package:equatable/equatable.dart';
import '../../../domain/entities/drop_task.dart';

/// Base class for Manage states
abstract class ManageState extends Equatable {
  const ManageState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ManageInitial extends ManageState {
  const ManageInitial();
}

/// Loading state
class ManageLoading extends ManageState {
  const ManageLoading();
}

/// Loaded state with tasks
class ManageLoaded extends ManageState {
  final List<DropTask> tasks;

  const ManageLoaded({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

/// Error state
class ManageError extends ManageState {
  final String message;

  const ManageError(this.message);

  @override
  List<Object?> get props => [message];
}

