import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/comment.dart';

part 'comment_state.freezed.dart';

@freezed
class CommentState with _$CommentState {
  const factory CommentState({
    @Default(false) bool isLoading,
    @Default('') String postId,
    @Default([]) List<Comment> comments,
    String? errorMessage,
  }) = _CommentState;
}
