import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_event.freezed.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.loadFavoritePosts(String userUID) =
      LoadFavoritePosts;
  const factory FavoritesEvent.addToFavorites({
    required String postId,
    required String userUID,
  }) = AddToFavorites;
  const factory FavoritesEvent.removeFromFavorites({
    required String postId,
    required String userUID,
  }) = RemoveFromFavorites;
  const factory FavoritesEvent.refreshFavoritePosts(String userUID) =
      RefreshFavoritePosts;
  const factory FavoritesEvent.unstarPost({
    required String postId,
    required String userUID,
  }) = UnstarPost;
  const factory FavoritesEvent.clearFavorites() = ClearFavorites;
}
