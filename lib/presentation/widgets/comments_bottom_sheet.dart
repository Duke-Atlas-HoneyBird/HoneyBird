import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/comment.dart';
import '../bloc/comment/comment_bloc.dart';
import '../bloc/comment/comment_event.dart';
import '../bloc/comment/comment_state.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../theme/border_radius.dart';

/// Bottom sheet that displays comments for a post and allows adding new ones.
/// Requires [CommentBloc] to be provided above (e.g. when showing the sheet).
/// [onCommentCountChanged] is called whenever the comments list changes so the feed can re-render with the new count.
class CommentsBottomSheet extends StatefulWidget {
  final String postId;
  final String? currentUserUID;
  final String? currentUserName;
  final void Function(int count)? onCommentCountChanged;

  const CommentsBottomSheet({
    super.key,
    required this.postId,
    this.currentUserUID,
    this.currentUserName,
    this.onCommentCountChanged,
  });

  static Future<void> show(
    BuildContext context, {
    required CommentBloc commentBloc,
    required String postId,
    String? currentUserUID,
    String? currentUserName,
    void Function(int count)? onCommentCountChanged,
  }) {
    commentBloc.add(CommentEvent.loadRequested(postId: postId));
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: commentBloc,
        child: CommentsBottomSheet(
          postId: postId,
          currentUserUID: currentUserUID,
          currentUserName: currentUserName,
          onCommentCountChanged: onCommentCountChanged,
        ),
      ),
    );
  }

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays > 7) {
      return DateFormat('MMM d, yyyy').format(date);
    } else if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void _submitComment() {
    final text = _controller.text.trim();
    if (text.isEmpty ||
        widget.currentUserUID == null ||
        widget.currentUserName == null) {
      return;
    }

    context.read<CommentBloc>().add(CommentEvent.createRequested(
          postId: widget.postId,
          text: text,
          userName: widget.currentUserName!,
          userUID: widget.currentUserUID!,
        ));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(cardBorderRadius)),
            ),
            child: Column(
            children: [
              // Handle bar
              Padding(
                padding: const EdgeInsets.only(top: spacingS),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: textSecondary.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: spacingS),
                child: Text(
                  'Comments',
                  style: headlineMedium,
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: BlocConsumer<CommentBloc, CommentState>(
                  listenWhen: (prev, curr) =>
                      curr.errorMessage != prev?.errorMessage ||
                      curr.comments.length != prev?.comments.length,
                  listener: (context, state) {
                    if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage!),
                          backgroundColor: errorColor,
                        ),
                      );
                    }
                    widget.onCommentCountChanged?.call(state.comments.length);
                  },
                  buildWhen: (prev, curr) =>
                      prev?.postId != curr.postId ||
                      prev?.isLoading != curr.isLoading ||
                      prev?.comments != curr.comments ||
                      prev?.errorMessage != curr.errorMessage,
                  builder: (context, state) {
                    if (state.isLoading && state.comments.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.errorMessage != null && state.comments.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(spacingL),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.errorMessage!,
                                style: bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: spacingM),
                              TextButton(
                                onPressed: () => context.read<CommentBloc>().add(
                                      CommentEvent.loadRequested(postId: widget.postId),
                                    ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    final comments = state.comments;
                    if (comments.isEmpty && !state.isLoading) {
                      return Center(
                        child: Text(
                          'No comments yet. Be the first!',
                          style: bodyMedium.copyWith(color: textSecondary),
                        ),
                      );
                    }
                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: spacingM,
                        vertical: spacingS,
                      ),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final c = comments[index];
                        return _CommentTile(
                          comment: c,
                          formatDate: _formatDate,
                        );
                      },
                    );
                  },
                ),
              ),
              if (widget.currentUserUID != null && widget.currentUserName != null) ...[
                const Divider(height: 1),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      spacingM,
                      spacingS,
                      spacingS,
                      spacingM,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                              hintStyle: bodyMedium.copyWith(color: textSecondary),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(buttonBorderRadius),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: spacingM,
                                vertical: spacingS,
                              ),
                            ),
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _submitComment(),
                            maxLines: null,
                          ),
                        ),
                        const SizedBox(width: spacingS),
                        IconButton.filled(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            _submitComment();
                          },
                          icon: const Icon(Icons.send),
                          style: IconButton.styleFrom(
                            backgroundColor: primaryPurple,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else
                Padding(
                  padding: const EdgeInsets.all(spacingM),
                  child: Text(
                    'Sign in to comment',
                    style: bodyMedium.copyWith(color: textSecondary),
                  ),
                ),
            ],
          ),
        );
      },
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final Comment comment;
  final String Function(DateTime) formatDate;

  const _CommentTile({
    required this.comment,
    required this.formatDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: spacingS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: primaryPurple,
            child: Text(
              comment.userName.isNotEmpty
                  ? comment.userName[0].toUpperCase()
                  : '?',
              style: labelLarge.copyWith(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(width: spacingS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.userName,
                      style: labelLarge.copyWith(fontSize: 13),
                    ),
                    const SizedBox(width: spacingXs),
                    Text(
                      formatDate(comment.publishedDate),
                      style: bodyMedium.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  comment.text,
                  style: bodyMedium.copyWith(color: textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
