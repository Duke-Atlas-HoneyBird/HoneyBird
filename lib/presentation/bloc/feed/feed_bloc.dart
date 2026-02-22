import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_message_utils.dart';
import '../../../application/use_cases/post/get_posts.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repositories/block_repository.dart';
import '../../../domain/repositories/favorite_repository.dart';
import '../../../domain/repositories/post_repository.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc(
    this._getPosts, {
    required PostRepository postRepository,
    required FavoriteRepository favoriteRepository,
    required BlockRepository blockRepository,
  })  : _postRepository = postRepository,
        _favoriteRepository = favoriteRepository,
        _blockRepository = blockRepository,
        super(const FeedState()) {
    on<LoadFeedPosts>(_onLoadFeedPosts);
    on<RefreshFeedPosts>(_onRefreshFeedPosts);
    on<FilterFeedByCategory>(_onFilterFeedByCategory);
    on<AddOrUpdatePostToFeed>(_onAddOrUpdatePostToFeed);
    on<LikePostInFeed>(_onLikePostInFeed);
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

  Future<void> _onLoadFeedPosts(
    LoadFeedPosts event,
    Emitter<FeedState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getPosts();

    await result.fold(
      (failure) async => emit(state.copyWith(
          isLoading: false,
          errorMessage: ErrorMessageUtils.forUi('load_feed'),
          posts: [])),
      (posts) async {
        final filtered = await _filterBlocked(posts, event.userUID);
        emit(state.copyWith(isLoading: false, posts: filtered));
      },
    );
  }

  Future<void> _onRefreshFeedPosts(
    RefreshFeedPosts event,
    Emitter<FeedState> emit,
  ) async {
    final result = await _getPosts();

    await result.fold(
      (failure) async => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('refresh_feed'))),
      (posts) async {
        final filtered = await _filterBlocked(posts, event.userUID);
        emit(state.copyWith(
            posts: filtered,
            selectedCategory: state.selectedCategory));
      },
    );
  }

  Future<void> _onFilterFeedByCategory(
    FilterFeedByCategory event,
    Emitter<FeedState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getPosts();

    await result.fold(
      (failure) async => emit(state.copyWith(
          isLoading: false,
          errorMessage: ErrorMessageUtils.forUi('filter_feed'),
          posts: [])),
      (allPosts) async {
        final filtered = await _filterBlocked(allPosts, null);
        emit(state.copyWith(
            isLoading: false,
            posts: filtered,
            selectedCategory: event.category));
      },
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

  Future<void> _onLikePostInFeed(
    LikePostInFeed event,
    Emitter<FeedState> emit,
  ) async {
    final result =
        await _postRepository.likePost(event.postId, event.userUID);

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('favorites'))),
      (updatedPost) async {
        if (updatedPost.likeIDs.contains(event.userUID)) {
          await _favoriteRepository.addToFavorites(event.postId, event.userUID);
        } else {
          await _favoriteRepository.removeFromFavorites(
              event.postId, event.userUID);
        }
        add(FeedEvent.addOrUpdatePostToFeed(updatedPost));
      },
    );
  }
}
