import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_count_state.freezed.dart';

@freezed
class CommentCountState with _$CommentCountState {
  const factory CommentCountState({
    @Default({}) Map<String, int> counts,
  }) = _CommentCountState;
}
