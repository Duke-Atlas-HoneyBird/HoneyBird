import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/message.dart';

/// Repository interface for message operations
abstract class MessageRepository {
  /// Get all conversations for a user
  Future<Either<Failure, List<Conversation>>> getConversations(String userUID);

  /// Get messages for a specific conversation
  Future<Either<Failure, List<Message>>> getMessages(String conversationId);

  /// Send a new message
  Future<Either<Failure, Message>> sendMessage(Message message);

  /// Mark messages as read
  Future<Either<Failure, void>> markAsRead(String conversationId, String userUID);

  /// Get unread message count for a user
  Future<Either<Failure, int>> getUnreadCount(String userUID);
}

