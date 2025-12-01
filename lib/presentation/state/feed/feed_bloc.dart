import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/post.dart';
import 'feed_event.dart';
import 'feed_state.dart';

/// Bloc for managing feed state and business logic
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(const FeedInitial()) {
    on<LoadFeedPosts>(_onLoadFeedPosts);
    on<RefreshFeedPosts>(_onRefreshFeedPosts);
    on<FilterFeedByCategory>(_onFilterFeedByCategory);
  }

  /// Generate dummy feed posts
  List<Post> _generateDummyFeedPosts() {
    final now = DateTime.now();
    return [
      Post(
        id: 'feed_1',
        text: 'Just discovered an amazing new restaurant in Cape Town! The food was incredible and the atmosphere was perfect for a date night. Highly recommend trying their signature dish!',
        publishedDate: now.subtract(const Duration(hours: 2)),
        userName: 'FoodieExplorer',
        userUID: 'user_feed_1',
        upvoteIDs: ['user1', 'user2', 'user3', 'user4'],
        downvoteIDs: [],
      ),
      Post(
        id: 'feed_2',
        text: 'Wine tasting at a local vineyard was absolutely breathtaking. The sunset views paired with excellent wines made for an unforgettable experience. Perfect for wine lovers!',
        publishedDate: now.subtract(const Duration(hours: 5)),
        userName: 'WineEnthusiast',
        userUID: 'user_feed_2',
        upvoteIDs: ['user1', 'user2', 'user3', 'user4', 'user5', 'user6'],
        downvoteIDs: ['user7'],
      ),
      Post(
        id: 'feed_3',
        text: 'Outdoor adventure at Table Mountain today! The hike was challenging but the views from the top were absolutely worth it. Nature never fails to amaze me.',
        publishedDate: now.subtract(const Duration(days: 1)),
        userName: 'AdventureSeeker',
        userUID: 'user_feed_3',
        upvoteIDs: ['user1', 'user2', 'user3'],
        downvoteIDs: [],
      ),
      Post(
        id: 'feed_4',
        text: 'Tried authentic Italian cuisine at a hidden gem in the city. The pasta was handmade and the flavors were incredible. A must-visit for Italian food lovers!',
        publishedDate: now.subtract(const Duration(days: 1, hours: 3)),
        userName: 'ItalianFoodLover',
        userUID: 'user_feed_4',
        upvoteIDs: ['user1', 'user2', 'user3', 'user4', 'user5'],
        downvoteIDs: ['user6'],
      ),
      Post(
        id: 'feed_5',
        text: 'Greek restaurant with amazing Mediterranean flavors! The moussaka was perfect and the atmosphere reminded me of my trip to Greece. Highly recommend!',
        publishedDate: now.subtract(const Duration(days: 2)),
        userName: 'MediterraneanFan',
        userUID: 'user_feed_5',
        upvoteIDs: ['user1', 'user2'],
        downvoteIDs: [],
      ),
      Post(
        id: 'feed_6',
        text: 'Chinese dim sum experience was outstanding! The variety of dumplings and the authentic flavors made this one of my best dining experiences this year.',
        publishedDate: now.subtract(const Duration(days: 2, hours: 5)),
        userName: 'DimSumLover',
        userUID: 'user_feed_6',
        upvoteIDs: ['user1', 'user2', 'user3', 'user4'],
        downvoteIDs: ['user5'],
      ),
      Post(
        id: 'feed_7',
        text: 'Thai street food market visit was incredible! The pad thai and green curry were authentic and delicious. Great place to explore different flavors!',
        publishedDate: now.subtract(const Duration(days: 3)),
        userName: 'ThaiFoodExplorer',
        userUID: 'user_feed_7',
        upvoteIDs: ['user1', 'user2', 'user3'],
        downvoteIDs: [],
      ),
      Post(
        id: 'feed_8',
        text: 'African cuisine restaurant with traditional dishes was a cultural experience! The flavors were rich and authentic. Loved learning about the different regional cuisines.',
        publishedDate: now.subtract(const Duration(days: 4)),
        userName: 'CulturalFoodie',
        userUID: 'user_feed_8',
        upvoteIDs: ['user1', 'user2', 'user3', 'user4', 'user5', 'user6', 'user7'],
        downvoteIDs: [],
      ),
    ];
  }

  Future<void> _onLoadFeedPosts(
    LoadFeedPosts event,
    Emitter<FeedState> emit,
  ) async {
    emit(const FeedLoading());
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    try {
      final posts = _generateDummyFeedPosts();
      emit(FeedLoaded(posts: posts));
    } catch (e) {
      emit(FeedError('Failed to load feed posts: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshFeedPosts(
    RefreshFeedPosts event,
    Emitter<FeedState> emit,
  ) async {
    // Keep current state if loaded
    if (state is FeedLoaded) {
      final currentState = state as FeedLoaded;
      emit(FeedLoaded(
        posts: currentState.posts,
        selectedCategory: currentState.selectedCategory,
      ));
    }
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      final posts = _generateDummyFeedPosts();
      final currentState = state;
      if (currentState is FeedLoaded) {
        emit(FeedLoaded(
          posts: posts,
          selectedCategory: currentState.selectedCategory,
        ));
      } else {
        emit(FeedLoaded(posts: posts));
      }
    } catch (e) {
      emit(FeedError('Failed to refresh feed posts: ${e.toString()}'));
    }
  }

  Future<void> _onFilterFeedByCategory(
    FilterFeedByCategory event,
    Emitter<FeedState> emit,
  ) async {
    emit(const FeedLoading());
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      final allPosts = _generateDummyFeedPosts();
      // In a real app, this would filter by category
      // For now, we'll just return all posts with the selected category
      emit(FeedLoaded(
        posts: allPosts,
        selectedCategory: event.category,
      ));
    } catch (e) {
      emit(FeedError('Failed to filter feed: ${e.toString()}'));
    }
  }
}

