import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/use_cases/post/get_posts.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc(this._getPosts) : super(const FeedState()) {
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
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getPosts();

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load feed: ${failure.message}',
          posts: [])),
      (posts) => emit(state.copyWith(isLoading: false, posts: posts)),
    );
  }

  Future<void> _onRefreshFeedPosts(
    RefreshFeedPosts event,
    Emitter<FeedState> emit,
  ) async {
    final result = await _getPosts();

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: 'Failed to refresh: ${failure.message}')),
      (posts) => emit(state.copyWith(
          posts: posts,
          selectedCategory: state.selectedCategory)),
    );
  }

  Future<void> _onFilterFeedByCategory(
    FilterFeedByCategory event,
    Emitter<FeedState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getPosts();

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to filter feed: ${failure.message}',
          posts: [])),
      (allPosts) => emit(state.copyWith(
          isLoading: false,
          posts: allPosts,
          selectedCategory: event.category)),
    );
  }

  FutureOr<void> _onAddOrUpdatePostToFeed(
      AddOrUpdatePostToFeed event, Emitter<FeedState> emit) {
    final updatedPosts = state.posts.map((post) {
      return post.id == event.post.id ? event.post : post;
    }).toList();
    emit(state.copyWith(
        posts: updatedPosts, selectedCategory: state.selectedCategory));
  }
}
