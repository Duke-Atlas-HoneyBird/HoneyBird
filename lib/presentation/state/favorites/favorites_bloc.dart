import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/favorite_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoriteRepository favoriteRepository;

  FavoritesBloc({required this.favoriteRepository})
      : super(const FavoritesState()) {
    on<LoadFavoritePosts>(_onLoadFavoritePosts);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<RefreshFavoritePosts>(_onRefreshFavoritePosts);
  }

  Future<void> _onLoadFavoritePosts(
    LoadFavoritePosts event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await favoriteRepository.getFavoritePosts(event.userUID);

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load favorite posts',
          posts: [])),
      (posts) => emit(state.copyWith(isLoading: false, posts: posts)),
    );
  }

  Future<void> _onAddToFavorites(
    AddToFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
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
    final result = await favoriteRepository.getFavoritePosts(event.userUID);

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: 'Failed to refresh favorites')),
      (posts) => emit(state.copyWith(posts: posts)),
    );
  }
}
