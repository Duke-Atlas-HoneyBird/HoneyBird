import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/post.dart';

part 'feed_state.freezed.dart';

@freezed
class FeedState with _$FeedState {
  const factory FeedState({
    @Default(false) bool isLoading,
    @Default([]) List<Post> posts,
    String? selectedCategory,
    String? errorMessage,
  }) = _FeedState;
}
