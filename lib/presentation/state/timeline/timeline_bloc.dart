import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/post.dart';
import 'timeline_event.dart';
import 'timeline_state.dart';

/// Bloc for managing timeline state and business logic
class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc() : super(const TimelineInitial()) {
    on<LoadTimelinePosts>(_onLoadTimelinePosts);
    on<RefreshTimelinePosts>(_onRefreshTimelinePosts);
    on<LoadMoreTimelinePosts>(_onLoadMoreTimelinePosts);
  }

  /// Generate dummy timeline posts (chronological order)
  List<Post> _generateDummyTimelinePosts({int count = 10}) {
    final now = DateTime.now();
    final posts = <Post>[];
    
    for (int i = 0; i < count; i++) {
      final date = now.subtract(Duration(
        days: i ~/ 3,
        hours: i % 3 * 2,
        minutes: i * 15,
      ));
      
      final postTexts = [
        'Just had an amazing dinner at a new restaurant! The food was incredible.',
        'Wine tasting experience was unforgettable. The vineyard views were breathtaking.',
        'Outdoor adventure today! Hiked up the mountain and enjoyed the scenic views.',
        'Tried authentic Italian cuisine. The pasta was handmade and delicious.',
        'Greek restaurant visit was fantastic! The moussaka reminded me of my trip to Greece.',
        'Chinese dim sum experience was outstanding! So many delicious options.',
        'Thai street food market was incredible! Authentic flavors everywhere.',
        'African cuisine restaurant visit was a cultural experience! Rich and flavorful.',
        'Wine farm tour was amazing! Learned so much about wine making.',
        'Outdoor picnic with friends was perfect! Great food and great company.',
        'New restaurant discovery! The chef\'s special was absolutely delicious.',
        'Food festival visit was exciting! Tried so many different cuisines.',
        'Cooking class was fun! Learned to make traditional dishes.',
        'Restaurant review: Excellent service and amazing food quality.',
        'Weekend getaway included amazing dining experiences!',
      ];
      
      final userNames = [
        'FoodieExplorer',
        'WineEnthusiast',
        'AdventureSeeker',
        'ItalianFoodLover',
        'MediterraneanFan',
        'DimSumLover',
        'ThaiFoodExplorer',
        'CulturalFoodie',
        'GourmetTraveler',
        'ChefAtHeart',
      ];
      
      posts.add(Post(
        id: 'timeline_$i',
        text: postTexts[i % postTexts.length],
        publishedDate: date,
        userName: userNames[i % userNames.length],
        userUID: 'user_timeline_$i',
        upvoteIDs: List.generate((i % 5) + 1, (j) => 'user$j'),
        downvoteIDs: i % 7 == 0 ? ['user_down'] : [],
      ));
    }
    
    // Sort by date (most recent first)
    posts.sort((a, b) => b.publishedDate.compareTo(a.publishedDate));
    
    return posts;
  }

  Future<void> _onLoadTimelinePosts(
    LoadTimelinePosts event,
    Emitter<TimelineState> emit,
  ) async {
    emit(const TimelineLoading());
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 700));
    
    try {
      final posts = _generateDummyTimelinePosts(count: 10);
      emit(TimelineLoaded(posts: posts, hasMore: true));
    } catch (e) {
      emit(TimelineError('Failed to load timeline posts: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshTimelinePosts(
    RefreshTimelinePosts event,
    Emitter<TimelineState> emit,
  ) async {
    final currentState = state;
    if (currentState is TimelineLoaded) {
      // Keep current posts while refreshing
      emit(currentState);
    }
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      final posts = _generateDummyTimelinePosts(count: 10);
      emit(TimelineLoaded(posts: posts, hasMore: true));
    } catch (e) {
      emit(TimelineError('Failed to refresh timeline posts: ${e.toString()}'));
    }
  }

  Future<void> _onLoadMoreTimelinePosts(
    LoadMoreTimelinePosts event,
    Emitter<TimelineState> emit,
  ) async {
    final currentState = state;
    if (currentState is TimelineLoaded) {
      if (currentState.isLoadingMore || !currentState.hasMore) {
        return;
      }
      
      emit(currentState.copyWith(isLoadingMore: true));
      
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 600));
      
      try {
        final existingPosts = currentState.posts;
        final newPosts = _generateDummyTimelinePosts(count: 5);
        final allPosts = [...existingPosts, ...newPosts];
        
        // Limit to 30 posts total
        final hasMore = allPosts.length < 30;
        final finalPosts = hasMore ? allPosts : allPosts.take(30).toList();
        
        emit(TimelineLoaded(
          posts: finalPosts,
          hasMore: hasMore,
          isLoadingMore: false,
        ));
      } catch (e) {
        emit(TimelineError('Failed to load more posts: ${e.toString()}'));
      }
    }
  }
}

