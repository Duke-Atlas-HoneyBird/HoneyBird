import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/border_radius.dart';
import '../theme/text_styles.dart';

/// Widget for displaying a message bubble in a B2C merchant conversation.
class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  Widget _buildMerchantAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(cardBorderRadius),
      child: Container(
        width: 32,
        height: 32,
        color: primaryPurple,
        alignment: Alignment.center,
        child: Icon(
          message.isSystemMessage ? Icons.info_outline : Icons.storefront,
          size: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (message.isSystemMessage) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: spacingM,
          vertical: spacingS,
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: spacingM,
              vertical: spacingS,
            ),
            decoration: BoxDecoration(
              color: primaryPurple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(cardBorderRadius),
              border: Border.all(color: primaryPurple.withValues(alpha: 0.2)),
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            child: Text(
              message.content,
              style: bodyMedium.copyWith(color: textSecondary),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final isMerchantReply = message.isFromMerchant;
    final bubbleColor =
        isCurrentUser ? accentPink : (isMerchantReply ? cardBackground : cardBackground);
    final textColor = isCurrentUser ? Colors.white : textPrimary;

    final bubble = Container(
      margin: const EdgeInsets.symmetric(
        horizontal: spacingM,
        vertical: spacingXs,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: spacingM,
        vertical: spacingS,
      ),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        border: isMerchantReply
            ? Border.all(color: primaryPurple.withValues(alpha: 0.25))
            : null,
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMerchantReply)
            Padding(
              padding: const EdgeInsets.only(bottom: spacingXs),
              child: Text(
                message.senderName,
                style: bodyMedium.copyWith(
                  color: primaryPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          Text(
            message.content,
            style: bodyMedium.copyWith(color: textColor),
            maxLines: 20,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: spacingXs),
          Text(
            _formatTime(message.timestamp),
            style: bodyMedium.copyWith(
              color: isCurrentUser
                  ? Colors.white.withValues(alpha: 0.7)
                  : textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );

    if (isCurrentUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: bubble,
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: spacingM),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildMerchantAvatar(),
            const SizedBox(width: spacingS),
            Flexible(child: bubble),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime date) {
    final hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }
}
