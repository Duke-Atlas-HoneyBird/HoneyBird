import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/uuid_utils.dart';
import '../models/message_model.dart';

/// Fake user IDs and names used for seeding test conversations.
const String _fakeUser1UID = 'fake_user_1';
const String _fakeUser1Name = 'Fake Alice';
const String _fakeUser2UID = 'fake_user_2';
const String _fakeUser2Name = 'Fake Bob';

/// Abstract interface for Firebase message data operations
abstract class FirebaseMessageDataSource {
  /// Get all conversations for a user
  Future<List<ConversationModel>> getConversations(String userUID);

  /// If the user has no conversations, create 2 fake conversations with messages for testing.
  Future<void> seedFakeConversationsIfEmpty(String userUID);

  /// Get messages for a specific conversation
  Future<List<MessageModel>> getMessages(String conversationId);

  /// Send a new message
  Future<MessageModel> sendMessage(MessageModel message, String? conversationId);

  /// Mark messages as read
  Future<void> markAsRead(String conversationId, String userUID);

  /// Get unread message count for a user
  Future<int> getUnreadCount(String userUID);
}

/// Implementation of FirebaseMessageDataSource using Cloud Firestore
class FirebaseMessageDataSourceImpl implements FirebaseMessageDataSource {
  final FirebaseFirestore firestore;

  FirebaseMessageDataSourceImpl({required this.firestore});

  CollectionReference get _conversations => firestore.collection(FirebaseCollections.conversations);

  @override
  Future<List<ConversationModel>> getConversations(String userUID) async {
    try {
      final snapshot = await _conversations
          .where('participants', arrayContains: userUID)
          .orderBy('lastUpdated', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
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
    try {
      final snapshot = await _conversations
          .doc(conversationId)
          .collection(FirebaseCollections.messages)
          .orderBy('timestamp', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Failed to get messages from Firestore: $e');
      throw ServerException('Failed to get messages from Firestore: $e');
    }
  }

  @override
  Future<MessageModel> sendMessage(MessageModel message, String? conversationId) async {
    try {
      String convId = conversationId ?? _generateConversationId(message.senderUID, message.receiverUID);
      
      final batch = firestore.batch();
      
      // 1. Add message to sub-collection
      final msgDoc = _conversations.doc(convId).collection(FirebaseCollections.messages).doc(message.id);
      batch.set(msgDoc, message.toJson());
      
      // 2. Update/Create conversation overview
      final convDoc = _conversations.doc(convId);
      final convData = ConversationModel(
        id: convId,
        participant1UID: message.senderUID,
        participant1Name: message.senderName,
        participant2UID: message.receiverUID,
        participant2Name: message.receiverName,
        lastMessage: message,
        lastUpdated: message.timestamp,
        unreadCount: 1, // This is simplified, real logic would increment if recipient
      );
      
      batch.set(convDoc, convData.toJson(), SetOptions(merge: true));
      
      await batch.commit();
      return message;
    } catch (e) {
      throw ServerException('Failed to send message in Firestore: $e');
    }
  }

  @override
  Future<void> markAsRead(String conversationId, String userUID) async {
    try {
      // In a real app, you'd find all messages in the conversation 
      // where receiverUID == userUID and isRead == false, and update them.
      // And also reset the unreadCount in the conversation document.
      
      await _conversations.doc(conversationId).update({
        'unreadCount': 0,
      });
      
      // Mark messages as read in sub-collection
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
          .where('participants', arrayContains: userUID)
          .get();
          
      int total = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        // Simple logic: if the last message was NOT sent by user, count the unreadCount
        // Real logic would be more complex (user-specific unread counts)
        if (data['lastMessage'] != null && data['lastMessage']['receiverUID'] == userUID) {
          total += (data['unreadCount'] as int? ?? 0);
        }
      }
      return total;
    } catch (e) {
      throw ServerException('Failed to get unread count: $e');
    }
  }

  @override
  Future<void> seedFakeConversationsIfEmpty(String userUID) async {
    final existing = await getConversations(userUID);
    if (existing.isNotEmpty) return;

    const currentUserName = 'You';
    final now = DateTime.now();

    // Conversation 1: user + Fake Alice (2 messages)
    await _seedConversation(
      userUID: userUID,
      userName: currentUserName,
      otherUID: _fakeUser1UID,
      otherName: _fakeUser1Name,
      message1: (_fakeUser1UID, _fakeUser1Name, userUID, currentUserName, 'Hi! Want to try the new recipe?', now.subtract(const Duration(minutes: 5))),
      message2: (userUID, currentUserName, _fakeUser1UID, _fakeUser1Name, 'Sure, sounds good!', now.subtract(const Duration(minutes: 4))),
    );

    // Conversation 2: user + Fake Bob (2 messages)
    await _seedConversation(
      userUID: userUID,
      userName: currentUserName,
      otherUID: _fakeUser2UID,
      otherName: _fakeUser2Name,
      message1: (_fakeUser2UID, _fakeUser2Name, userUID, currentUserName, 'Hey, did you see the post about honey?', now.subtract(const Duration(minutes: 10))),
      message2: (userUID, currentUserName, _fakeUser2UID, _fakeUser2Name, 'Yes, loved it!', now.subtract(const Duration(minutes: 9))),
    );
  }

  Future<void> _seedConversation({
    required String userUID,
    required String userName,
    required String otherUID,
    required String otherName,
    required (String, String, String, String, String, DateTime) message1,
    required (String, String, String, String, String, DateTime) message2,
  }) async {
    final convId = _generateConversationId(userUID, otherUID);
    final ids = [userUID, otherUID]..sort();
    final p1 = ids[0];
    final p2 = ids[1];
    final p1Name = p1 == userUID ? userName : otherName;
    final p2Name = p2 == userUID ? userName : otherName;

    final msg1 = MessageModel(
      id: UuidUtils.generate(),
      senderUID: message1.$1,
      senderName: message1.$2,
      receiverUID: message1.$3,
      receiverName: message1.$4,
      content: message1.$5,
      timestamp: message1.$6,
      isRead: true,
    );
    final msg2 = MessageModel(
      id: UuidUtils.generate(),
      senderUID: message2.$1,
      senderName: message2.$2,
      receiverUID: message2.$3,
      receiverName: message2.$4,
      content: message2.$5,
      timestamp: message2.$6,
      isRead: true,
    );

    final convData = ConversationModel(
      id: convId,
      participant1UID: p1,
      participant1Name: p1Name,
      participant2UID: p2,
      participant2Name: p2Name,
      lastMessage: msg2,
      lastUpdated: msg2.timestamp,
      unreadCount: 0,
    );

    final batch = firestore.batch();
    final convRef = _conversations.doc(convId);
    batch.set(convRef, convData.toJson(), SetOptions(merge: true));
    batch.set(
      convRef.collection(FirebaseCollections.messages).doc(msg1.id),
      msg1.toJson(),
    );
    batch.set(
      convRef.collection(FirebaseCollections.messages).doc(msg2.id),
      msg2.toJson(),
    );
    await batch.commit();
  }

  String _generateConversationId(String uid1, String uid2) {
    // Consistent ID regardless of who starts the conversation
    List<String> ids = [uid1, uid2];
    ids.sort();
    return ids.join('_');
  }
}
