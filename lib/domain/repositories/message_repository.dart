import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/message.dart';

/// Repository interface for mediated B2C message operations.
abstract class MessageRepository {
  /// Get all user–restaurant conversations for a user.
  Future<Either<Failure, List<Conversation>>> getConversations(String userUID);

  /// Get messages for a specific conversation.
  Future<Either<Failure, List<Message>>> getMessages(String conversationId);

  /// Send a message to a restaurant. Pass [conversationId] when replying.
  Future<Either<Failure, Message>> sendMessage(
    Message message, {
    String? conversationId,
  });

  /// Mark merchant replies as read.
  Future<Either<Failure, void>> markAsRead(
    String conversationId,
    String userUID,
  );

  /// Get unread merchant reply count.
  Future<Either<Failure, int>> getUnreadCount(String userUID);

  /// Create a new conversation with the merchant channel notice if needed.
  Future<Either<Failure, void>> ensureMerchantChannelNotice({
    required String userUID,
    required String userName,
    required String restaurantId,
    required String restaurantName,
  });
}
