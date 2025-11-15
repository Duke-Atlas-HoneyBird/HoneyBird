import '../../domain/entities/drop_task.dart';
import '../../domain/entities/drop_status.dart';

/// Infrastructure model for DropTask entity with local storage serialization.
/// 
/// Extends the domain DropTask entity and adds JSON serialization capabilities
/// with proper enum conversion for DropStatus.
class DropTaskModel extends DropTask {
  const DropTaskModel({
    required super.id,
    required super.title,
    required super.status,
  });

  /// Creates a DropTaskModel from a JSON map (local storage).
  /// 
  /// Converts string to DropStatus enum.
  factory DropTaskModel.fromJson(Map<String, dynamic> json) {
    return DropTaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      status: _statusFromString(json['status'] as String),
    );
  }

  /// Converts this DropTaskModel to a JSON map for local storage.
  /// 
  /// Converts DropStatus enum to string.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': _statusToString(status),
    };
  }

  /// Creates a DropTaskModel from a domain DropTask entity.
  factory DropTaskModel.fromEntity(DropTask task) {
    return DropTaskModel(
      id: task.id,
      title: task.title,
      status: task.status,
    );
  }

  /// Converts a string to DropStatus enum.
  static DropStatus _statusFromString(String status) {
    switch (status) {
      case 'todo':
        return DropStatus.todo;
      case 'working':
        return DropStatus.working;
      case 'completed':
        return DropStatus.completed;
      default:
        return DropStatus.todo;
    }
  }

  /// Converts a DropStatus enum to string.
  static String _statusToString(DropStatus status) {
    switch (status) {
      case DropStatus.todo:
        return 'todo';
      case DropStatus.working:
        return 'working';
      case DropStatus.completed:
        return 'completed';
    }
  }
}
