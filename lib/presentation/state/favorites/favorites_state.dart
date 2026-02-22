import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/post.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default(false) bool isLoading,
    @Default([]) List<Post> posts,
    String? errorMessage,
  }) = _FavoritesState;
}
