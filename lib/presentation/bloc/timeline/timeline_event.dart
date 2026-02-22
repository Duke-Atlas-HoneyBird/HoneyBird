import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/post.dart';

part 'timeline_event.freezed.dart';

@freezed
class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent.loadTimelinePosts({String? userUID}) = LoadTimelinePosts;
  const factory TimelineEvent.refreshTimelinePosts({String? userUID}) = RefreshTimelinePosts;
  const factory TimelineEvent.loadMoreTimelinePosts({String? userUID}) = LoadMoreTimelinePosts;
  const factory TimelineEvent.updateTimelinePost(Post post) =
      UpdateTimelinePost;
  const factory TimelineEvent.likePostInTimeline({
    required String postId,
    required String userUID,
  }) = LikePostInTimeline;
}
