import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_count_event.freezed.dart';

@freezed
class CommentCountEvent with _$CommentCountEvent {
  const factory CommentCountEvent.loadCountsForPosts({
    required List<String> postIds,
  }) = LoadCountsForPosts;

  const factory CommentCountEvent.countUpdated({
    required String postId,
    required int count,
  }) = CountUpdated;
}
