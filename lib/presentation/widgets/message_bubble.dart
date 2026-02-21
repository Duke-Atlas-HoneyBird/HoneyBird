import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/border_radius.dart';
import '../theme/text_styles.dart';

/// Widget for displaying a message bubble in a conversation
class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: spacingM,
          vertical: spacingXs,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: spacingM,
          vertical: spacingS,
        ),
        decoration: BoxDecoration(
          color: isCurrentUser ? accentPink : cardBackground,
          borderRadius: BorderRadius.circular(cardBorderRadius),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: bodyMedium.copyWith(
                color: isCurrentUser ? Colors.white : textPrimary,
              ),
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

