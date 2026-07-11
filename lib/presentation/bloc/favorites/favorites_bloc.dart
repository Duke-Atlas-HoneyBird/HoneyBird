import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_message_utils.dart';
import '../../../domain/repositories/favorite_repository.dart';
import '../../../domain/repositories/post_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoriteRepository favoriteRepository;
  final PostRepository postRepository;

  FavoritesBloc({
    required this.favoriteRepository,
    required this.postRepository,
  }) : super(const FavoritesState()) {
    on<LoadFavoritePosts>(_onLoadFavoritePosts);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<RefreshFavoritePosts>(_onRefreshFavoritePosts);
    on<UnstarPost>(_onUnstarPost);
    on<ClearFavorites>(_onClearFavorites);
  }

  bool _isCurrentUser(String userUID) =>
      userUID.isNotEmpty &&
      (state.userUID == null || state.userUID == userUID);

  Future<void> _onLoadFavoritePosts(
    LoadFavoritePosts event,
    Emitter<FavoritesState> emit,
  ) async {
    if (event.userUID.isEmpty) {
      emit(const FavoritesState());
      return;
    }

    final userChanged =
        state.userUID != null && state.userUID != event.userUID;
    final loadForUid = event.userUID;

    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      userUID: loadForUid,
      posts: userChanged ? [] : state.posts,
    ));

    final result = await favoriteRepository.getFavoritePosts(loadForUid);

    if (state.userUID != loadForUid) return;

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load favorite posts',
        posts: [],
      )),
      (posts) => emit(state.copyWith(isLoading: false, posts: posts)),
    );
  }

  Future<void> _onAddToFavorites(
    AddToFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    if (!_isCurrentUser(event.userUID)) return;

    final result = await favoriteRepository.addToFavorites(
        event.postId, event.userUID);

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: 'Failed to add to favorites')),
      (_) => add(FavoritesEvent.loadFavoritePosts(event.userUID)),
    );
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    if (!_isCurrentUser(event.userUID)) return;

    final result = await favoriteRepository.removeFromFavorites(
        event.postId, event.userUID);

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: 'Failed to remove from favorites')),
      (_) => add(FavoritesEvent.loadFavoritePosts(event.userUID)),
    );
  }

  Future<void> _onRefreshFavoritePosts(
    RefreshFavoritePosts event,
    Emitter<FavoritesState> emit,
  ) async {
    if (event.userUID.isEmpty) return;

    final refreshForUid = event.userUID;
    final result = await favoriteRepository.getFavoritePosts(refreshForUid);

    if (state.userUID != refreshForUid) return;

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: 'Failed to refresh favorites')),
      (posts) => emit(state.copyWith(posts: posts)),
    );
  }

  Future<void> _onUnstarPost(
    UnstarPost event,
    Emitter<FavoritesState> emit,
  ) async {
    if (!_isCurrentUser(event.userUID)) return;

    final likeResult =
        await postRepository.likePost(event.postId, event.userUID);

    await likeResult.fold(
      (failure) async => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('favorites'))),
      (_) async {
        await favoriteRepository.removeFromFavorites(
            event.postId, event.userUID);
        add(FavoritesEvent.refreshFavoritePosts(event.userUID));
      },
    );
  }

  void _onClearFavorites(
    ClearFavorites event,
    Emitter<FavoritesState> emit,
  ) {
    emit(const FavoritesState());
  }
}
