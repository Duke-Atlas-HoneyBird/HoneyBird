import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_message_utils.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/entities/user_preference.dart';
import '../../../domain/repositories/block_repository.dart';
import '../../../domain/repositories/favorite_repository.dart';
import '../../../domain/repositories/post_repository.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/repositories/user_preference_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final UserPreferenceRepository _preferenceRepository;
  final BlockRepository _blockRepository;
  final PostRepository _postRepository;
  final FavoriteRepository _favoriteRepository;

  ProfileBloc({
    required UserRepository userRepository,
    required UserPreferenceRepository preferenceRepository,
    required BlockRepository blockRepository,
    required PostRepository postRepository,
    required FavoriteRepository favoriteRepository,
  })  : _userRepository = userRepository,
        _preferenceRepository = preferenceRepository,
        _blockRepository = blockRepository,
        _postRepository = postRepository,
        _favoriteRepository = favoriteRepository,
        super(const ProfileState()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<LikePostInProfile>(_onLikePostInProfile);
    on<AddOrUpdatePostInProfile>(_onAddOrUpdatePostInProfile);
    on<BlockUser>(_onBlockUser);
    on<UnblockUser>(_onUnblockUser);
  }

  Future<void> _onLoadUserProfile(
    LoadUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      isLoadingPosts: true,
      errorMessage: null,
    ));

    final userResult = await _userRepository.getUserByUID(event.targetUserUID);
    final isBlockedResult = await _blockRepository.isBlocked(
      event.viewerUserUID,
      event.targetUserUID,
    );
    final postsResult =
        await _postRepository.getPostsByUserUID(event.targetUserUID);

    await userResult.fold(
      (failure) async => emit(state.copyWith(
        isLoading: false,
        isLoadingPosts: false,
        errorMessage: ErrorMessageUtils.forUi('load_profile'),
      )),
      (user) async {
        // Load preferences - may fail if user hasn't set them
        UserPreference? prefs;
        if (event.targetUserUID == event.viewerUserUID) {
          prefs = state.preferences;
        }

        final isBlocked = isBlockedResult.fold((_) => false, (b) => b);
        final posts = postsResult.fold(
          (_) => <Post>[],
          (list) => list,
        );
        final postsError = postsResult.fold(
          (_) => ErrorMessageUtils.forUi('load_posts'),
          (_) => null,
        );

        emit(state.copyWith(
          isLoading: false,
          isLoadingPosts: false,
          user: user,
          preferences: prefs,
          posts: posts,
          isBlocked: isBlocked,
          errorMessage: postsError,
        ));
      },
    );
  }

  Future<void> _onLikePostInProfile(
    LikePostInProfile event,
    Emitter<ProfileState> emit,
  ) async {
    final result =
        await _postRepository.likePost(event.postId, event.userUID);

    await result.fold(
      (failure) async => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('favorites'))),
      (updatedPost) async {
        if (updatedPost.likeIDs.contains(event.userUID)) {
          await _favoriteRepository.addToFavorites(event.postId, event.userUID);
        } else {
          await _favoriteRepository.removeFromFavorites(
              event.postId, event.userUID);
        }
        add(ProfileEvent.addOrUpdatePostInProfile(updatedPost));
      },
    );
  }

  FutureOr<void> _onAddOrUpdatePostInProfile(
    AddOrUpdatePostInProfile event,
    Emitter<ProfileState> emit,
  ) {
    final updatedPosts = state.posts.map((post) {
      return post.id == event.post.id ? event.post : post;
    }).toList();
    emit(state.copyWith(posts: updatedPosts, errorMessage: null));
  }

  Future<void> _onBlockUser(
    BlockUser event,
    Emitter<ProfileState> emit,
  ) async {
    final result =
        await _blockRepository.blockUser(event.currentUserUID, event.targetUserUID);

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('block'))),
      (_) => emit(state.copyWith(isBlocked: true, errorMessage: null)),
    );
  }

  Future<void> _onUnblockUser(
    UnblockUser event,
    Emitter<ProfileState> emit,
  ) async {
    final result = await _blockRepository.unblockUser(
      event.currentUserUID,
      event.targetUserUID,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('unblock'))),
      (_) => emit(state.copyWith(isBlocked: false, errorMessage: null)),
    );
  }
}
