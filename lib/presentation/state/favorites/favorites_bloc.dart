import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/favorite_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

/// Bloc for managing favorites state and business logic
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoriteRepository favoriteRepository;

  FavoritesBloc({required this.favoriteRepository}) : super(const FavoritesInitial()) {
    on<LoadFavoritePosts>(_onLoadFavoritePosts);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<RefreshFavoritePosts>(_onRefreshFavoritePosts);
  }

  Future<void> _onLoadFavoritePosts(
    LoadFavoritePosts event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());
    
    final result = await favoriteRepository.getFavoritePosts(event.userUID);
    
    result.fold(
      (failure) => emit(const FavoritesError('Failed to load favorite posts')),
      (posts) => emit(FavoritesLoaded(posts: posts)),
    );
  }

  Future<void> _onAddToFavorites(
    AddToFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final result = await favoriteRepository.addToFavorites(event.postId, event.userUID);
    
    result.fold(
      (failure) => emit(const FavoritesError('Failed to add to favorites')),
      (_) {
        // Reload favorites
        add(LoadFavoritePosts(event.userUID));
      },
    );
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final result = await favoriteRepository.removeFromFavorites(event.postId, event.userUID);
    
    result.fold(
      (failure) => emit(const FavoritesError('Failed to remove from favorites')),
      (_) {
        // Reload favorites
        add(LoadFavoritePosts(event.userUID));
      },
    );
  }

  Future<void> _onRefreshFavoritePosts(
    RefreshFavoritePosts event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      // Keep current posts while refreshing
      emit(FavoritesLoaded(posts: currentState.posts));
    }
    
    final result = await favoriteRepository.getFavoritePosts(event.userUID);
    
    result.fold(
      (failure) => emit(const FavoritesError('Failed to refresh favorites')),
      (posts) => emit(FavoritesLoaded(posts: posts)),
    );
  }
}

