import 'package:equatable/equatable.dart';
import '../../core/utils/uuid_utils.dart';

/// B2C conversation channel — user to restaurant only.
enum ConversationType {
  userRestaurant('user_restaurant');

  final String firestoreValue;
  const ConversationType(this.firestoreValue);

  static ConversationType fromFirestore(String? value) {
    if (value == ConversationType.userRestaurant.firestoreValue) {
      return ConversationType.userRestaurant;
    }
    return ConversationType.userRestaurant;
  }
}

/// Who sent a message in a mediated B2C channel.
enum MessageSenderType {
  user('user'),
  merchant('merchant'),
  system('system');

  final String firestoreValue;
  const MessageSenderType(this.firestoreValue);

  static MessageSenderType fromFirestore(String? value) {
    switch (value) {
      case 'merchant':
        return MessageSenderType.merchant;
      case 'system':
        return MessageSenderType.system;
      default:
        return MessageSenderType.user;
    }
  }
}

/// Domain entity representing a message routed through the platform backend.
///
/// User messages are addressed to the restaurant entity; merchant replies
/// are routed back to the user via the backend — never user-to-user.
class Message extends Equatable {
  final String id;
  final MessageSenderType senderType;
  final String senderUID;
  final String senderName;
  final String receiverUID;
  final String receiverName;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  Message({
    String? id,
    this.senderType = MessageSenderType.user,
    required this.senderUID,
    required this.senderName,
    required this.receiverUID,
    required this.receiverName,
    required this.content,
    required this.timestamp,
    this.isRead = false,
  }) : id = id ?? UuidUtils.generate();

  bool get isFromMerchant => senderType == MessageSenderType.merchant;
  bool get isSystemMessage => senderType == MessageSenderType.system;

  @override
  List<Object?> get props => [
        id,
        senderType,
        senderUID,
        senderName,
        receiverUID,
        receiverName,
        content,
        timestamp,
        isRead,
      ];
}

/// Mediated B2C conversation between a user and a restaurant entity.
class Conversation extends Equatable {
  final String id;
  final ConversationType conversationType;
  final String userUID;
  final String userName;
  final String restaurantId;
  final String restaurantName;
  final Message? lastMessage;
  final DateTime lastUpdated;
  final int unreadCount;

  Conversation({
    String? id,
    this.conversationType = ConversationType.userRestaurant,
    required this.userUID,
    required this.userName,
    required this.restaurantId,
    required this.restaurantName,
    this.lastMessage,
    required this.lastUpdated,
    this.unreadCount = 0,
  }) : id = id ?? UuidUtils.generate();

  /// Consistent ID for a user–restaurant thread.
  static String idFor(String userUID, String restaurantId) =>
      'user_${userUID}_restaurant_$restaurantId';

  @override
  List<Object?> get props => [
        id,
        conversationType,
        userUID,
        userName,
        restaurantId,
        restaurantName,
        lastMessage,
        lastUpdated,
        unreadCount,
      ];
}
