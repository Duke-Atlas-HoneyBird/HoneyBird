import 'package:equatable/equatable.dart';
import '../../core/utils/uuid_utils.dart';

/// Domain entity representing a comment on a post.
///
/// This entity is immutable and uses value equality for comparison.
class Comment extends Equatable {
  final String id;
  final String postId;
  final String text;
  final DateTime publishedDate;
  final String userName;
  final String userUID;

  Comment({
    String? id,
    required this.postId,
    required this.text,
    required this.publishedDate,
    required this.userName,
    required this.userUID,
  }) : id = id ?? UuidUtils.generate();

  @override
  List<Object?> get props => [id, postId, text, publishedDate, userName, userUID];
}
