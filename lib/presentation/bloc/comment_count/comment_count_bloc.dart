import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/comment_repository.dart';
import 'comment_count_event.dart';
import 'comment_count_state.dart';

class CommentCountBloc extends Bloc<CommentCountEvent, CommentCountState> {
  final CommentRepository _commentRepository;

  CommentCountBloc({
    required CommentRepository commentRepository,
  })  : _commentRepository = commentRepository,
        super(const CommentCountState()) {
    on<LoadCountsForPosts>(_onLoadCountsForPosts);
    on<CountUpdated>(_onCountUpdated);
  }

  Future<void> _onLoadCountsForPosts(
    LoadCountsForPosts event,
    Emitter<CommentCountState> emit,
  ) async {
    if (event.postIds.isEmpty) return;
    // Skip if we already have counts for all (avoid refetch on every rebuild)
    final missing =
        event.postIds.where((id) => !state.counts.containsKey(id)).toList();
    if (missing.isEmpty) return;

    final results = await Future.wait(
      missing.map((postId) => _commentRepository.getCommentCountForPost(postId)),
    );

    final Map<String, int> updated = Map.from(state.counts);
    for (var i = 0; i < missing.length; i++) {
      results[i].fold(
        (_) => updated[missing[i]] = 0,
        (count) => updated[missing[i]] = count,
      );
    }
    emit(state.copyWith(counts: updated));
  }

  void _onCountUpdated(
    CountUpdated event,
    Emitter<CommentCountState> emit,
  ) {
    final updated = Map<String, int>.from(state.counts);
    updated[event.postId] = event.count;
    emit(state.copyWith(counts: updated));
  }
}
