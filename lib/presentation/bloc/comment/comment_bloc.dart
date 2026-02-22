import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_message_utils.dart';
import '../../../domain/entities/comment.dart';
import '../../../domain/repositories/comment_repository.dart';
import 'comment_event.dart';
import 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository _commentRepository;

  CommentBloc({
    required CommentRepository commentRepository,
  })  : _commentRepository = commentRepository,
        super(const CommentState()) {
    on<CommentsLoadRequested>(_onCommentsLoadRequested);
    on<CommentCreateRequested>(_onCommentCreateRequested);
  }

  Future<void> _onCommentsLoadRequested(
    CommentsLoadRequested event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(
        isLoading: true, errorMessage: null, postId: event.postId, comments: []));

    final result = await _commentRepository.getCommentsForPost(event.postId);

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: ErrorMessageUtils.forUi('comments'), comments: [])),
      (comments) => emit(state.copyWith(
          isLoading: false, postId: event.postId, comments: comments, errorMessage: null)),
    );
  }

  Future<void> _onCommentCreateRequested(
    CommentCreateRequested event,
    Emitter<CommentState> emit,
  ) async {
    if (event.text.trim().isEmpty) return;

    final comment = Comment(
      postId: event.postId,
      text: event.text.trim(),
      publishedDate: DateTime.now(),
      userName: event.userName,
      userUID: event.userUID,
    );

    final result = await _commentRepository.createComment(comment);

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: ErrorMessageUtils.forUi('comment_create'))),
      (created) {
        if (state.postId == event.postId) {
          final updated = [...state.comments, created];
          emit(state.copyWith(comments: updated, errorMessage: null));
        } else {
          add(CommentEvent.loadRequested(postId: event.postId));
        }
      },
    );
  }
}
