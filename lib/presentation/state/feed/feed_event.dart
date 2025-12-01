import 'package:equatable/equatable.dart';

/// Base class for Feed events
abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load feed posts
class LoadFeedPosts extends FeedEvent {
  const LoadFeedPosts();
}

/// Event to refresh feed posts
class RefreshFeedPosts extends FeedEvent {
  const RefreshFeedPosts();
}

/// Event to filter feed by category
class FilterFeedByCategory extends FeedEvent {
  final String category;

  const FilterFeedByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

