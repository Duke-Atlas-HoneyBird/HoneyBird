import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/message.dart';

/// Infrastructure model for Message entity with Firestore serialization.
class MessageModel extends Message {
  MessageModel({
    super.id,
    super.senderType = MessageSenderType.user,
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
      senderType: MessageSenderType.fromFirestore(json['senderType'] as String?),
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
      'senderType': senderType.firestoreValue,
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
      senderType: message.senderType,
      senderUID: message.senderUID,
      senderName: message.senderName,
      receiverUID: message.receiverUID,
      receiverName: message.receiverName,
      content: message.content,
      timestamp: message.timestamp,
      isRead: message.isRead,
    );
  }

  /// System notice shown when a user opens a new merchant conversation.
  factory MessageModel.merchantChannelNotice({
    required String restaurantName,
    required DateTime timestamp,
  }) {
    return MessageModel(
      senderType: MessageSenderType.system,
      senderUID: 'platform',
      senderName: 'Honey Bird',
      receiverUID: '',
      receiverName: '',
      content:
          'You are contacting $restaurantName through Honey Bird. '
          'Messages are routed to the restaurant for order-related inquiries — '
          'not to other users.',
      timestamp: timestamp,
      isRead: true,
    );
  }
}

/// Infrastructure model for Conversation entity with Firestore serialization.
class ConversationModel extends Conversation {
  ConversationModel({
    super.id,
    super.conversationType = ConversationType.userRestaurant,
    required super.userUID,
    required super.userName,
    required super.restaurantId,
    required super.restaurantName,
    super.lastMessage,
    required super.lastUpdated,
    super.unreadCount = 0,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as String?,
      conversationType:
          ConversationType.fromFirestore(json['conversationType'] as String?),
      userUID: json['userUID'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      restaurantId: json['restaurantId'] as String? ?? '',
      restaurantName: json['restaurantName'] as String? ?? 'Restaurant',
      lastMessage: json['lastMessage'] != null
          ? MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>)
          : null,
      lastUpdated: (json['lastUpdated'] as Timestamp).toDate(),
      unreadCount: json['unreadCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final message = lastMessage;
    return {
      'id': id,
      'conversationType': conversationType.firestoreValue,
      'userUID': userUID,
      'userName': userName,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'lastMessage': message != null
          ? MessageModel.fromEntity(message).toJson()
          : null,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
      'unreadCount': unreadCount,
    };
  }

  factory ConversationModel.fromEntity(Conversation conversation) {
    return ConversationModel(
      id: conversation.id,
      conversationType: conversation.conversationType,
      userUID: conversation.userUID,
      userName: conversation.userName,
      restaurantId: conversation.restaurantId,
      restaurantName: conversation.restaurantName,
      lastMessage: conversation.lastMessage,
      lastUpdated: conversation.lastUpdated,
      unreadCount: conversation.unreadCount,
    );
  }
}
