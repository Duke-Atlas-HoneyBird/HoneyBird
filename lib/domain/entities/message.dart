import 'package:equatable/equatable.dart';

/// Domain entity representing a message in the system.
/// 
/// This entity is immutable and uses value equality for comparison.
class Message extends Equatable {
  final String? id;
  final String senderUID;
  final String senderName;
  final String receiverUID;
  final String receiverName;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  const Message({
    this.id,
    required this.senderUID,
    required this.senderName,
    required this.receiverUID,
    required this.receiverName,
    required this.content,
    required this.timestamp,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [
        id,
        senderUID,
        senderName,
        receiverUID,
        receiverName,
        content,
        timestamp,
        isRead,
      ];
}

/// Domain entity representing a conversation between users.
class Conversation extends Equatable {
  final String? id;
  final String participant1UID;
  final String participant1Name;
  final String participant2UID;
  final String participant2Name;
  final Message? lastMessage;
  final DateTime lastUpdated;
  final int unreadCount;

  const Conversation({
    this.id,
    required this.participant1UID,
    required this.participant1Name,
    required this.participant2UID,
    required this.participant2Name,
    this.lastMessage,
    required this.lastUpdated,
    this.unreadCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        participant1UID,
        participant1Name,
        participant2UID,
        participant2Name,
        lastMessage,
        lastUpdated,
        unreadCount,
      ];
}

