import 'package:equatable/equatable.dart';
import 'drop_status.dart';
import '../../core/utils/uuid_utils.dart';

/// Domain entity representing a task in the system.
/// 
/// This entity is immutable and uses value equality for comparison.
/// Uses UUID-based identification.
class DropTask extends Equatable {
  final String id;
  final String title;
  final DropStatus status;
  final String userUID;

  DropTask({
    String? id,
    required this.title,
    required this.status,
    required this.userUID,
  }) : id = id ?? UuidUtils.generate();

  @override
  List<Object?> get props => [id, title, status, userUID];
}
