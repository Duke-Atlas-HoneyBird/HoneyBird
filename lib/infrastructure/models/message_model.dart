import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/message.dart';

/// Infrastructure model for Message entity with Firestore serialization.
class MessageModel extends Message {
  MessageModel({
    super.id,
    required super.senderUID,
    required super.senderName,
    required super.receiverUID,
    required super.receiverName,
    required super.content,
    required super.timestamp,
    super.isRead = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String?,
      senderUID: json['senderUID'] as String,
      senderName: json['senderName'] as String,
      receiverUID: json['receiverUID'] as String,
      receiverName: json['receiverName'] as String,
      content: json['content'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderUID': senderUID,
      'senderName': senderName,
      'receiverUID': receiverUID,
      'receiverName': receiverName,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
      'isRead': isRead,
    };
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      senderUID: message.senderUID,
      senderName: message.senderName,
      receiverUID: message.receiverUID,
      receiverName: message.receiverName,
      content: message.content,
      timestamp: message.timestamp,
      isRead: message.isRead,
    );
  }
}

/// Infrastructure model for Conversation entity with Firestore serialization.
class ConversationModel extends Conversation {
  ConversationModel({
    super.id,
    required super.participant1UID,
    required super.participant1Name,
    required super.participant2UID,
    required super.participant2Name,
    super.participants,
    super.lastMessage,
    required super.lastUpdated,
    super.unreadCount = 0,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as String?,
      participant1UID: json['participant1UID'] as String,
      participant1Name: json['participant1Name'] as String,
      participant2UID: json['participant2UID'] as String,
      participant2Name: json['participant2Name'] as String,
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastMessage: json['lastMessage'] != null 
          ? MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>)
          : null,
      lastUpdated: (json['lastUpdated'] as Timestamp).toDate(),
      unreadCount: json['unreadCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participant1UID': participant1UID,
      'participant1Name': participant1Name,
      'participant2UID': participant2UID,
      'participant2Name': participant2Name,
      'participants': participants,
      'lastMessage': lastMessage != null 
          ? MessageModel.fromEntity(lastMessage!).toJson()
          : null,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
      'unreadCount': unreadCount,
    };
  }

  factory ConversationModel.fromEntity(Conversation conversation) {
    return ConversationModel(
      id: conversation.id,
      participant1UID: conversation.participant1UID,
      participant1Name: conversation.participant1Name,
      participant2UID: conversation.participant2UID,
      participant2Name: conversation.participant2Name,
      participants: conversation.participants,
      lastMessage: conversation.lastMessage,
      lastUpdated: conversation.lastUpdated,
      unreadCount: conversation.unreadCount,
    );
  }
}
