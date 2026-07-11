import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/message.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../theme/border_radius.dart';

/// Widget for displaying a B2C restaurant conversation in the messages list.
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

  @override
  Widget build(BuildContext context) {
    final restaurantName = conversation.restaurantName;
    final hasUnread = conversation.unreadCount > 0;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: spacingM,
        vertical: spacingS,
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          child: Container(
            width: 56,
            height: 56,
            color: primaryPurple,
            alignment: Alignment.center,
            child: const Icon(
              Icons.storefront,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantName,
                    style: labelLarge.copyWith(
                      fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Merchant · Order inquiries',
                    style: bodyMedium.copyWith(
                      color: textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
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
                      conversation.lastMessage!.isSystemMessage
                          ? 'Merchant channel opened'
                          : conversation.lastMessage!.content,
                      style: bodyMedium.copyWith(
                        fontWeight:
                            hasUnread ? FontWeight.w500 : FontWeight.normal,
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
