import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/post.dart';

part 'timeline_event.freezed.dart';

@freezed
class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent.loadTimelinePosts() = LoadTimelinePosts;
  const factory TimelineEvent.refreshTimelinePosts() = RefreshTimelinePosts;
  const factory TimelineEvent.loadMoreTimelinePosts() = LoadMoreTimelinePosts;
  const factory TimelineEvent.updateTimelinePost(Post post) =
      UpdateTimelinePost;
}
