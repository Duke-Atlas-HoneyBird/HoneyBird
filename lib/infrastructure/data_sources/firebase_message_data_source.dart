import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../../domain/entities/message.dart';
import '../models/message_model.dart';

/// Abstract interface for Firebase B2C message data operations.
abstract class FirebaseMessageDataSource {
  /// Get all user–restaurant conversations for a user.
  Future<List<ConversationModel>> getConversations(String userUID);

  /// Get messages for a specific conversation.
  Future<List<MessageModel>> getMessages(String conversationId);

  /// Send a user message to a restaurant via the mediated channel.
  Future<MessageModel> sendMessage(MessageModel message, String? conversationId);

  /// Mark merchant replies as read for the user.
  Future<void> markAsRead(String conversationId, String userUID);

  /// Get unread merchant reply count for a user.
  Future<int> getUnreadCount(String userUID);

  /// Ensure the merchant channel notice exists for a new conversation.
  Future<void> ensureMerchantChannelNotice({
    required String conversationId,
    required String userUID,
    required String userName,
    required String restaurantId,
    required String restaurantName,
  });
}

/// Implementation routing all message traffic user ↔ restaurant via Firestore.
class FirebaseMessageDataSourceImpl implements FirebaseMessageDataSource {
  final FirebaseFirestore firestore;

  FirebaseMessageDataSourceImpl({required this.firestore});

  CollectionReference get _conversations =>
      firestore.collection(FirebaseCollections.conversations);

  @override
  Future<List<ConversationModel>> getConversations(String userUID) async {
    try {
      final snapshot = await _conversations
          .where('userUID', isEqualTo: userUID)
          .where('conversationType',
              isEqualTo: ConversationType.userRestaurant.firestoreValue)
          .orderBy('lastUpdated', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data =
            Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
        data['id'] = doc.id;
        return ConversationModel.fromJson(data);
      }).toList();
    } catch (e) {
      print(e);
      throw ServerException('Failed to get conversations from Firestore: $e');
    }
  }

  @override
  Future<List<MessageModel>> getMessages(String conversationId) async {
    return _getMessagesWithRetry(conversationId, retryCount: 0);
  }

  Future<List<MessageModel>> _getMessagesWithRetry(
    String conversationId, {
    required int retryCount,
  }) async {
    try {
      final snapshot = await _conversations
          .doc(conversationId)
          .collection(FirebaseCollections.messages)
          .orderBy('timestamp', descending: false)
          .get();

      return snapshot.docs
          .map((doc) =>
              MessageModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      final errStr = e.toString();
      if (errStr.contains('permission-denied') && retryCount < 1) {
        await Future<void>.delayed(const Duration(milliseconds: 1500));
        return _getMessagesWithRetry(conversationId, retryCount: retryCount + 1);
      }
      print('Failed to get messages from Firestore: $e');
      throw ServerException('Failed to get messages from Firestore: $e');
    }
  }

  @override
  Future<MessageModel> sendMessage(
    MessageModel message,
    String? conversationId,
  ) async {
    return _sendMessageWithRetry(message, conversationId, retryCount: 0);
  }

  Future<MessageModel> _sendMessageWithRetry(
    MessageModel message,
    String? conversationId, {
    required int retryCount,
  }) async {
    try {
      final convId = conversationId ??
          Conversation.idFor(message.senderUID, message.receiverUID);

      final batch = firestore.batch();

      final convData = ConversationModel(
        id: convId,
        userUID: message.senderUID,
        userName: message.senderName,
        restaurantId: message.receiverUID,
        restaurantName: message.receiverName,
        lastMessage: message,
        lastUpdated: message.timestamp,
        unreadCount: 0,
      );
      batch.set(
        _conversations.doc(convId),
        convData.toJson(),
        SetOptions(merge: true),
      );

      final msgDoc = _conversations
          .doc(convId)
          .collection(FirebaseCollections.messages)
          .doc(message.id);
      batch.set(msgDoc, message.toJson());

      await batch.commit();
      return message;
    } catch (e) {
      final errStr = e.toString();
      if (errStr.contains('permission-denied') && retryCount < 1) {
        await Future<void>.delayed(const Duration(milliseconds: 1500));
        return _sendMessageWithRetry(message, conversationId,
            retryCount: retryCount + 1);
      }
      throw ServerException('Failed to send message in Firestore: $e');
    }
  }

  @override
  Future<void> markAsRead(String conversationId, String userUID) async {
    try {
      await _conversations.doc(conversationId).update({'unreadCount': 0});

      final unreadMsgs = await _conversations
          .doc(conversationId)
          .collection(FirebaseCollections.messages)
          .where('receiverUID', isEqualTo: userUID)
          .where('isRead', isEqualTo: false)
          .get();

      final batch = firestore.batch();
      for (var doc in unreadMsgs.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      await batch.commit();
    } catch (e) {
      throw ServerException('Failed to mark messages as read: $e');
    }
  }

  @override
  Future<int> getUnreadCount(String userUID) async {
    try {
      final snapshot = await _conversations
          .where('userUID', isEqualTo: userUID)
          .where('conversationType',
              isEqualTo: ConversationType.userRestaurant.firestoreValue)
          .get();

      int total = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data['lastMessage'] != null &&
            data['lastMessage']['receiverUID'] == userUID) {
          total += data['unreadCount'] as int? ?? 0;
        }
      }
      return total;
    } catch (e) {
      throw ServerException('Failed to get unread count: $e');
    }
  }

  @override
  Future<void> ensureMerchantChannelNotice({
    required String conversationId,
    required String userUID,
    required String userName,
    required String restaurantId,
    required String restaurantName,
  }) async {
    final convRef = _conversations.doc(conversationId);
    final existing = await convRef.get();
    if (existing.exists) return;

    final notice = MessageModel.merchantChannelNotice(
      restaurantName: restaurantName,
      timestamp: DateTime.now(),
    );

    final convData = ConversationModel(
      id: conversationId,
      userUID: userUID,
      userName: userName,
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      lastMessage: notice,
      lastUpdated: notice.timestamp,
      unreadCount: 0,
    );

    final batch = firestore.batch();
    batch.set(convRef, convData.toJson());
    batch.set(
      convRef.collection(FirebaseCollections.messages).doc(notice.id),
      notice.toJson(),
    );
    await batch.commit();
  }
}
