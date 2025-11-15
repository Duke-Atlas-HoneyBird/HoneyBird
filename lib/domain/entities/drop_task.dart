import 'package:equatable/equatable.dart';
import 'drop_status.dart';

/// Domain entity representing a task in the system.
/// 
/// This entity is immutable and uses value equality for comparison.
/// Uses UUID-based identification.
class DropTask extends Equatable {
  final String id;
  final String title;
  final DropStatus status;

  const DropTask({
    required this.id,
    required this.title,
    required this.status,
  });

  @override
  List<Object?> get props => [id, title, status];
}
