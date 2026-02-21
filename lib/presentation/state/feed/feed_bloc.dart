import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/use_cases/post/get_posts.dart';
import 'feed_event.dart';
import 'feed_state.dart';

/// Bloc for managing feed state; loads posts from Firebase.
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc(this._getPosts) : super(const FeedInitial()) {
    on<LoadFeedPosts>(_onLoadFeedPosts);
    on<RefreshFeedPosts>(_onRefreshFeedPosts);
    on<FilterFeedByCategory>(_onFilterFeedByCategory);
    on<AddOrUpdatePostToFeed>(_onAddOrUpdatePostToFeed);

  }

  final GetPosts _getPosts;

  Future<void> _onLoadFeedPosts(
    LoadFeedPosts event,
    Emitter<FeedState> emit,
  ) async {
    emit(const FeedLoading());

    final result = await _getPosts();

    result.fold(
      (failure) => emit(FeedError('Failed to load feed: ${failure.message}')),
      (posts) => emit(FeedLoaded(posts: posts)),
    );
  }

  Future<void> _onRefreshFeedPosts(
    RefreshFeedPosts event,
    Emitter<FeedState> emit,
  ) async {
    if (state is FeedLoaded) {
      final currentState = state as FeedLoaded;
      emit(FeedLoaded(
        posts: currentState.posts,
        selectedCategory: currentState.selectedCategory,
      ));
    }

    final result = await _getPosts();

    result.fold(
      (failure) => emit(FeedError('Failed to refresh: ${failure.message}')),
      (posts) {
        final currentState = state;
        if (currentState is FeedLoaded) {
          emit(FeedLoaded(
            posts: posts,
            selectedCategory: currentState.selectedCategory,
          ));
        } else {
          emit(FeedLoaded(posts: posts));
        }
      },
    );
  }

  Future<void> _onFilterFeedByCategory(
    FilterFeedByCategory event,
    Emitter<FeedState> emit,
  ) async {
    emit(const FeedLoading());

    final result = await _getPosts();

    result.fold(
      (failure) => emit(FeedError('Failed to filter feed: ${failure.message}')),
      (allPosts) => emit(FeedLoaded(
        posts: allPosts,
        selectedCategory: event.category,
      )),
    );
  }

  FutureOr<void> _onAddOrUpdatePostToFeed(AddOrUpdatePostToFeed event, Emitter<FeedState> emit) {
    final currentState = state;
    if (currentState is FeedLoaded) {
      final updatedPosts = currentState.posts.map((post) {
        return post.id == event.post.id ? event.post : post;
      }).toList();
      emit(FeedLoaded(
        posts: updatedPosts,
        selectedCategory: currentState.selectedCategory,
      ));
    }
  }
}

