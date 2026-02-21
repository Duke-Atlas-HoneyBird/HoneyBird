import 'package:equatable/equatable.dart';
import 'package:honey_bird/domain/entities/post.dart';

/// Base class for Timeline events
abstract class TimelineEvent extends Equatable {
  const TimelineEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load timeline posts
class LoadTimelinePosts extends TimelineEvent {
  const LoadTimelinePosts();
}

/// Event to refresh timeline posts
class RefreshTimelinePosts extends TimelineEvent {
  const RefreshTimelinePosts();
}

/// Event to load more timeline posts (pagination)
class LoadMoreTimelinePosts extends TimelineEvent {
  const LoadMoreTimelinePosts();
}

// make a event to update TimelineLoaded if one post changes (e.g. like/unlike) without reloading all posts
class UpdateTimelinePost extends TimelineEvent {
  final Post post;

  const UpdateTimelinePost(this.post);

  @override
  List<Object?> get props => [post];
}