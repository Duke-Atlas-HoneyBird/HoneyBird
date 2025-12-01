import 'package:equatable/equatable.dart';

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

