import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/use_cases/post/get_posts.dart';
import 'timeline_event.dart';
import 'timeline_state.dart';

/// Bloc for timeline state; loads posts from Firebase (chronological).
class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(this._getPosts) : super(const TimelineInitial()) {
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
    emit(const TimelineLoading());

    final result = await _getPosts();

    result.fold(
      (failure) =>
          emit(TimelineError('Failed to load timeline: ${failure.message}')),
      (posts) => emit(TimelineLoaded(posts: posts, hasMore: false)),
    );
  }

  Future<void> _onRefreshTimelinePosts(
    RefreshTimelinePosts event,
    Emitter<TimelineState> emit,
  ) async {
    final currentState = state;
    if (currentState is TimelineLoaded) {
      emit(currentState);
    }

    final result = await _getPosts();

    result.fold(
      (failure) =>
          emit(TimelineError('Failed to refresh: ${failure.message}')),
      (posts) => emit(TimelineLoaded(posts: posts, hasMore: false)),
    );
  }

  Future<void> _onLoadMoreTimelinePosts(
    LoadMoreTimelinePosts event,
    Emitter<TimelineState> emit,
  ) async {
    // Firebase getPosts returns all; pagination can be added later.
    final currentState = state;
    if (currentState is TimelineLoaded && currentState.hasMore) {
      final result = await _getPosts();
      result.fold(
        (failure) => emit(TimelineError('Failed to load more: ${failure.message}')),
        (posts) => emit(currentState.copyWith(
          posts: posts,
          hasMore: false,
          isLoadingMore: false,
        )),
      );
    }
  }

  FutureOr<void> _onUpdateTimelinePost(UpdateTimelinePost event, Emitter<TimelineState> emit) {
    final currentState = state;
    if (currentState is TimelineLoaded) {
      final updatedPosts = currentState.posts.map((post) {
        return post.id == event.post.id ? event.post : post;
      }).toList();
      emit(currentState.copyWith(posts: updatedPosts));
    }
  }
}

