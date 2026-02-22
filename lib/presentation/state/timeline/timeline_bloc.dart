import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/use_cases/post/get_posts.dart';
import 'timeline_event.dart';
import 'timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(this._getPosts) : super(const TimelineState()) {
    on<LoadTimelinePosts>(_onLoadTimelinePosts);
    on<RefreshTimelinePosts>(_onRefreshTimelinePosts);
    on<LoadMoreTimelinePosts>(_onLoadMoreTimelinePosts);
    on<UpdateTimelinePost>(_onUpdateTimelinePost);
  }

  final GetPosts _getPosts;

  Future<void> _onLoadTimelinePosts(
    LoadTimelinePosts event,
    Emitter<TimelineState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getPosts();

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load timeline: ${failure.message}',
          posts: [])),
      (posts) => emit(state.copyWith(
          isLoading: false, posts: posts, hasMore: false)),
    );
  }

  Future<void> _onRefreshTimelinePosts(
    RefreshTimelinePosts event,
    Emitter<TimelineState> emit,
  ) async {
    final result = await _getPosts();

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: 'Failed to refresh: ${failure.message}')),
      (posts) => emit(state.copyWith(posts: posts, hasMore: false)),
    );
  }

  Future<void> _onLoadMoreTimelinePosts(
    LoadMoreTimelinePosts event,
    Emitter<TimelineState> emit,
  ) async {
    if (!state.hasMore) return;

    final result = await _getPosts();
    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: 'Failed to load more: ${failure.message}',
          isLoadingMore: false)),
      (posts) => emit(state.copyWith(
          posts: posts, hasMore: false, isLoadingMore: false)),
    );
  }

  FutureOr<void> _onUpdateTimelinePost(
      UpdateTimelinePost event, Emitter<TimelineState> emit) {
    final updatedPosts = state.posts.map((post) {
      return post.id == event.post.id ? event.post : post;
    }).toList();
    emit(state.copyWith(posts: updatedPosts));
  }
}
