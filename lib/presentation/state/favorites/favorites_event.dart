import 'package:equatable/equatable.dart';

/// Base class for Favorites events
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load favorite posts
class LoadFavoritePosts extends FavoritesEvent {
  final String userUID;

  const LoadFavoritePosts(this.userUID);

  @override
  List<Object?> get props => [userUID];
}

/// Event to add post to favorites
class AddToFavorites extends FavoritesEvent {
  final String postId;
  final String userUID;

  const AddToFavorites({
    required this.postId,
    required this.userUID,
  });

  @override
  List<Object?> get props => [postId, userUID];
}

/// Event to remove post from favorites
class RemoveFromFavorites extends FavoritesEvent {
  final String postId;
  final String userUID;

  const RemoveFromFavorites({
    required this.postId,
    required this.userUID,
  });

  @override
  List<Object?> get props => [postId, userUID];
}

/// Event to refresh favorite posts
class RefreshFavoritePosts extends FavoritesEvent {
  final String userUID;

  const RefreshFavoritePosts(this.userUID);

  @override
  List<Object?> get props => [userUID];
}

