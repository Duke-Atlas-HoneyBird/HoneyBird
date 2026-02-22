import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/post.dart';

part 'feed_event.freezed.dart';

@freezed
class FeedEvent with _$FeedEvent {
  const factory FeedEvent.loadFeedPosts() = LoadFeedPosts;
  const factory FeedEvent.refreshFeedPosts() = RefreshFeedPosts;
  const factory FeedEvent.filterFeedByCategory(String category) =
      FilterFeedByCategory;
  const factory FeedEvent.addOrUpdatePostToFeed(Post post) =
      AddOrUpdatePostToFeed;
}
