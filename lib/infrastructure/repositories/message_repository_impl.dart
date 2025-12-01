import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';

/// Implementation of MessageRepository with dummy data
class MessageRepositoryImpl implements MessageRepository {
  @override
  Future<Either<Failure, List<Conversation>>> getConversations(String userUID) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Generate dummy conversations
    final now = DateTime.now();
    final conversations = [
      Conversation(
        id: 'conv_1',
        participant1UID: userUID,
        participant1Name: 'You',
        participant2UID: 'user_2',
        participant2Name: 'Sarah Johnson',
        lastMessage: Message(
          id: 'msg_1',
          senderUID: 'user_2',
          senderName: 'Sarah Johnson',
          receiverUID: userUID,
          receiverName: 'You',
          content: 'Hey! Are you free this weekend?',
          timestamp: now.subtract(const Duration(hours: 2)),
          isRead: false,
        ),
        lastUpdated: now.subtract(const Duration(hours: 2)),
        unreadCount: 2,
      ),
      Conversation(
        id: 'conv_2',
        participant1UID: userUID,
        participant1Name: 'You',
        participant2UID: 'user_3',
        participant2Name: 'Mike Chen',
        lastMessage: Message(
          id: 'msg_2',
          senderUID: userUID,
          senderName: 'You',
          receiverUID: 'user_3',
          receiverName: 'Mike Chen',
          content: 'Thanks for the recommendation!',
          timestamp: now.subtract(const Duration(days: 1)),
          isRead: true,
        ),
        lastUpdated: now.subtract(const Duration(days: 1)),
        unreadCount: 0,
      ),
      Conversation(
        id: 'conv_3',
        participant1UID: userUID,
        participant1Name: 'You',
        participant2UID: 'user_4',
        participant2Name: 'Emma Wilson',
        lastMessage: Message(
          id: 'msg_3',
          senderUID: 'user_4',
          senderName: 'Emma Wilson',
          receiverUID: userUID,
          receiverName: 'You',
          content: 'The restaurant was amazing! We should go again.',
          timestamp: now.subtract(const Duration(days: 2)),
          isRead: true,
        ),
        lastUpdated: now.subtract(const Duration(days: 2)),
        unreadCount: 0,
      ),
    ];
    
    return Right(conversations);
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages(String conversationId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    // Generate dummy messages
    final now = DateTime.now();
    final messages = [
      Message(
        id: 'msg_1',
        senderUID: 'user_2',
        senderName: 'Sarah Johnson',
        receiverUID: 'current_user',
        receiverName: 'You',
        content: 'Hey! Are you free this weekend?',
        timestamp: now.subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      Message(
        id: 'msg_2',
        senderUID: 'current_user',
        senderName: 'You',
        receiverUID: 'user_2',
        receiverName: 'Sarah Johnson',
        content: 'Yes, I am! What did you have in mind?',
        timestamp: now.subtract(const Duration(hours: 1, minutes: 45)),
        isRead: true,
      ),
      Message(
        id: 'msg_3',
        senderUID: 'user_2',
        senderName: 'Sarah Johnson',
        receiverUID: 'current_user',
        receiverName: 'You',
        content: 'I found this amazing new restaurant. Want to check it out?',
        timestamp: now.subtract(const Duration(hours: 1, minutes: 30)),
        isRead: false,
      ),
      Message(
        id: 'msg_4',
        senderUID: 'user_2',
        senderName: 'Sarah Johnson',
        receiverUID: 'current_user',
        receiverName: 'You',
        content: 'It has great reviews and the menu looks fantastic!',
        timestamp: now.subtract(const Duration(hours: 1)),
        isRead: false,
      ),
    ];
    
    return Right(messages);
  }

  @override
  Future<Either<Failure, Message>> sendMessage(Message message) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Return the message with an ID
    final sentMessage = Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderUID: message.senderUID,
      senderName: message.senderName,
      receiverUID: message.receiverUID,
      receiverName: message.receiverName,
      content: message.content,
      timestamp: DateTime.now(),
      isRead: false,
    );
    
    return Right(sentMessage);
  }

  @override
  Future<Either<Failure, void>> markAsRead(String conversationId, String userUID) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    return const Right(null);
  }

  @override
  Future<Either<Failure, int>> getUnreadCount(String userUID) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    return const Right(2);
  }
}

