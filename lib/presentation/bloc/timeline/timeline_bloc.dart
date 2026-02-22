import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_message_utils.dart';
import '../../../application/use_cases/post/get_posts.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repositories/block_repository.dart';
import '../../../domain/repositories/favorite_repository.dart';
import '../../../domain/repositories/post_repository.dart';
import 'timeline_event.dart';
import 'timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(
    this._getPosts, {
    required PostRepository postRepository,
    required FavoriteRepository favoriteRepository,
    required BlockRepository blockRepository,
  })  : _postRepository = postRepository,
        _favoriteRepository = favoriteRepository,
        _blockRepository = blockRepository,
        super(const TimelineState()) {
    on<LoadTimelinePosts>(_onLoadTimelinePosts);
    on<RefreshTimelinePosts>(_onRefreshTimelinePosts);
    on<LoadMoreTimelinePosts>(_onLoadMoreTimelinePosts);
    on<UpdateTimelinePost>(_onUpdateTimelinePost);
    on<LikePostInTimeline>(_onLikePostInTimeline);
  }

  final GetPosts _getPosts;
  final PostRepository _postRepository;
  final FavoriteRepository _favoriteRepository;
  final BlockRepository _blockRepository;

  Future<List<Post>> _filterBlocked(List<Post> posts, String? userUID) async {
    if (userUID == null || userUID.isEmpty) return posts;
    final blockedResult = await _blockRepository.getBlockedUserIds(userUID);
    return blockedResult.fold(
      (_) => posts,
      (blockedIds) {
        if (blockedIds.isEmpty) return posts;
        final blockedSet = blockedIds.toSet();
        return posts.where((p) => !blockedSet.contains(p.userUID)).toList();
      },
    );
  }

  Future<void> _onLoadTimelinePosts(
    LoadTimelinePosts event,
    Emitter<TimelineState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getPosts();

    await result.fold(
      (failure) async => emit(state.copyWith(
          isLoading: false,
          errorMessage: ErrorMessageUtils.forUi('load_timeline'),
          posts: [])),
      (posts) async {
        final filtered = await _filterBlocked(posts, event.userUID);
        emit(state.copyWith(
            isLoading: false, posts: filtered, hasMore: false));
      },
    );
  }

  Future<void> _onRefreshTimelinePosts(
    RefreshTimelinePosts event,
    Emitter<TimelineState> emit,
  ) async {
    final result = await _getPosts();

    await result.fold(
      (failure) async => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('refresh_timeline'))),
      (posts) async {
        final filtered = await _filterBlocked(posts, event.userUID);
        emit(state.copyWith(posts: filtered, hasMore: false));
      },
    );
  }

  Future<void> _onLoadMoreTimelinePosts(
    LoadMoreTimelinePosts event,
    Emitter<TimelineState> emit,
  ) async {
    if (!state.hasMore) return;

    final result = await _getPosts();
    await result.fold(
      (failure) async => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('load_more_timeline'),
          isLoadingMore: false)),
      (posts) async {
        final filtered = await _filterBlocked(posts, event.userUID);
        emit(state.copyWith(
            posts: filtered, hasMore: false, isLoadingMore: false));
      },
    );
  }

  FutureOr<void> _onUpdateTimelinePost(
      UpdateTimelinePost event, Emitter<TimelineState> emit) {
    final updatedPosts = state.posts.map((post) {
      return post.id == event.post.id ? event.post : post;
    }).toList();
    emit(state.copyWith(posts: updatedPosts));
  }

  Future<void> _onLikePostInTimeline(
    LikePostInTimeline event,
    Emitter<TimelineState> emit,
  ) async {
    final result =
        await _postRepository.likePost(event.postId, event.userUID);

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('update_timeline'))),
      (updatedPost) async {
        if (updatedPost.likeIDs.contains(event.userUID)) {
          await _favoriteRepository.addToFavorites(event.postId, event.userUID);
        } else {
          await _favoriteRepository.removeFromFavorites(
              event.postId, event.userUID);
        }
        add(TimelineEvent.updateTimelinePost(updatedPost));
      },
    );
  }
}
