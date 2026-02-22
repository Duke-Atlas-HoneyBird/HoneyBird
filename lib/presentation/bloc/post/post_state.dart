import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/post.dart';

part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState {
  const factory PostState({
    @Default(false) bool isLoading,
    @Default([]) List<Post> posts,
    String? errorMessage,
    Post? lastCreatedPost,
    Post? lastUpdatedPost,
  }) = _PostState;
}
