import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/message.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../theme/constants.dart';
import '../theme/border_radius.dart';

/// Widget for displaying a conversation item in the messages list
class ConversationItem extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationItem({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  String _formatTimestamp(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return DateFormat('MMM d').format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  String _getOtherParticipantName() {
    // Assuming current user is participant1, return participant2 name
    return conversation.participant2Name;
  }

  @override
  Widget build(BuildContext context) {
    final otherName = _getOtherParticipantName();
    final hasUnread = conversation.unreadCount > 0;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: spacingM,
        vertical: spacingS,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: primaryPurple,
          child: Text(
            otherName.isNotEmpty ? otherName[0].toUpperCase() : '?',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                otherName,
                style: labelLarge.copyWith(
                  fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (conversation.lastMessage != null)
              Text(
                _formatTimestamp(conversation.lastMessage!.timestamp),
                style: bodyMedium.copyWith(
                  color: textSecondary,
                ),
              ),
          ],
        ),
        subtitle: conversation.lastMessage != null
            ? Row(
                children: [
                  Expanded(
                    child: Text(
                      conversation.lastMessage!.content,
                      style: bodyMedium.copyWith(
                        fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (hasUnread)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: spacingS,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: accentPink,
                        borderRadius: BorderRadius.circular(cardBorderRadius),
                      ),
                      child: Text(
                        conversation.unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ),
                ],
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}

