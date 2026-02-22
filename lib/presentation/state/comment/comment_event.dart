import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_event.freezed.dart';

@freezed
class CommentEvent with _$CommentEvent {
  const factory CommentEvent.loadRequested({required String postId}) =
      CommentsLoadRequested;
  const factory CommentEvent.createRequested({
    required String postId,
    required String text,
    required String userName,
    required String userUID,
  }) = CommentCreateRequested;
}
