import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants.dart';
import '../utils/uuid_utils.dart';
import '../../domain/entities/drop_status.dart';
import '../../infrastructure/models/post_model.dart';
import '../../infrastructure/models/user_model.dart';
import '../../infrastructure/models/message_model.dart';
import '../../infrastructure/models/drop_task_model.dart';
import '../../infrastructure/models/user_preference_model.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/drop_task.dart';

class DataSeeder {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Consistent IDs for seeding to maintain relationships
  static final String _user1Id = '4g1nB3dDSFZu953CO4S6FpAjsZq1';
  static final String _user2Id = 'O0fLgx3srCb1hFErBxPn1bt3CpB2';
  static final String _user3Id = 'Y8z9kL2mP5nR1qT7vX4w3S6A9B0C1';
  
  static final String _post1Id = UuidUtils.generate();
  static final String _post2Id = UuidUtils.generate();
  static final String _post3Id = UuidUtils.generate();

  Future<void> seedFirestore() async {
    print('Starting Firestore seeding...');

    try {
      await _seedUsers();
      await _seedPosts();
      await _seedFavorites();
      await _seedPreferences();
      await _seedTasks();
      await _seedMessages();
      print('Firestore seeding completed successfully!');
    } catch (e) {
      print('Error during seeding: $e');
    }
  }

  Future<void> _seedFavorites() async {
    // For the first user, seed some favorites
    final favoritePostIds = [_post1Id, _post2Id];

    await _firestore
        .collection(FirebaseCollections.favorites)
        .doc(_user1Id)
        .set({
      'postIds': favoritePostIds,
    });
    print('Seeded favorites for user: $_user1Id');
  }

  Future<void> _seedUsers() async {
    final users = [
      User(
        id: _user1Id,
        userName: 'FoodieExplorer',
        userBio: 'Food enthusiast exploring Cape Town',
        userBioLink: 'https://example.com/foodie',
        userUID: _user1Id,
        userEmail: 'foodie@example.com',
      ),
      User(
        id: _user2Id,
        userName: 'WineEnthusiast',
        userBio: 'Wine lover and vineyard explorer',
        userBioLink: 'https://example.com/wine',
        userUID: _user2Id,
        userEmail: 'wine@example.com',
      ),
      User(
        id: _user3Id,
        userName: 'AdventureSeeker',
        userBio: 'Hiker and outdoor adventure lover',
        userBioLink: 'https://example.com/adventure',
        userUID: _user3Id,
        userEmail: 'adventure@example.com',
      ),
    ];

    final collection = _firestore.collection(FirebaseCollections.users);

    for (final user in users) {
      final model = UserModel.fromEntity(user);
      await collection.doc(user.id).set(model.toJson());
      print('Seeded user: ${user.userName}');
    }
  }

  Future<void> _seedPosts() async {
    final now = DateTime.now();
    final posts = [
      Post(
        id: _post1Id,
        text: 'Just discovered an amazing new restaurant in Cape Town! The food was incredible and the atmosphere was perfect for a date night. Highly recommend trying their signature dish!',
        publishedDate: now.subtract(const Duration(hours: 2)),
        userName: 'FoodieExplorer',
        userUID: _user1Id,
        likeIDs: const ['user1', 'user2', 'user3', 'user4'],
      ),
      Post(
        id: _post2Id,
        text: 'Wine tasting at a local vineyard was absolutely breathtaking. The sunset views paired with excellent wines made for an unforgettable experience. Perfect for wine lovers!',
        publishedDate: now.subtract(const Duration(hours: 5)),
        userName: 'WineEnthusiast',
        userUID: _user2Id,
        likeIDs: const ['user1', 'user2', 'user3', 'user4', 'user5', 'user6'],
      ),
      Post(
        id: _post3Id,
        text: 'Outdoor adventure at Table Mountain today! The hike was challenging but the views from the top were absolutely worth it. Nature never fails to amaze me.',
        publishedDate: now.subtract(const Duration(days: 1)),
        userName: 'AdventureSeeker',
        userUID: _user3Id,
        likeIDs: const ['user1', 'user2', 'user3'],
      ),
    ];

    final collection = _firestore.collection(FirebaseCollections.posts);

    for (final post in posts) {
      final model = PostModel.fromEntity(post);
      await collection.doc(post.id).set(model.toJson());
      print('Seeded post by: ${post.userName}');
    }
  }

  Future<void> _seedPreferences() async {
    final userIds = [_user1Id, _user2Id, _user3Id];
    final collection = _firestore.collection(FirebaseCollections.preferences);

    for (final uid in userIds) {
      final model = UserPreferenceModel(
        id: uid, // Preferred ID for preferences is the userUID
        vegan: uid == _user1Id,
        outdoor: uid == _user3Id,
        wineTasting: uid == _user2Id,
      );
      await collection.doc(uid).set(model.toJson());
      print('Seeded preferences for user: $uid');
    }
  }

  Future<void> _seedTasks() async {
    final taskData = [
      {'uid': _user1Id, 'title': 'Buy ingredients for date night', 'status': DropStatus.todo},
      {'uid': _user1Id, 'title': 'Book restaurant table', 'status': DropStatus.completed},
      {'uid': _user2Id, 'title': 'Order wine samples', 'status': DropStatus.working},
      {'uid': _user3Id, 'title': 'Check hiking gear', 'status': DropStatus.todo},
    ];

    final collection = _firestore.collection(FirebaseCollections.tasks);

    for (final data in taskData) {
      final task = DropTask(
        title: data['title'] as String,
        status: data['status'] as DropStatus,
        userUID: data['uid'] as String,
      );
      final model = DropTaskModel.fromEntity(task);
      await collection.doc(task.id).set(model.toJson());
      print('Seeded task for user: ${data['uid']}');
    }
  }

  Future<void> _seedMessages() async {
    final now = DateTime.now();
    final conversations = _firestore.collection(FirebaseCollections.conversations);

    // Conv 1: User 1 and User 2
    final conv1Id = _generateConversationId(_user1Id, _user2Id);
    final msg1 = MessageModel(
      senderUID: _user2Id,
      senderName: 'WineEnthusiast',
      receiverUID: _user1Id,
      receiverName: 'FoodieExplorer',
      content: 'Hey! Are you free this weekend?',
      timestamp: now.subtract(const Duration(hours: 2)),
    );

    final batch = _firestore.batch();
    
    // Add conv document
    final conv1 = ConversationModel(
      id: conv1Id,
      participant1UID: _user1Id,
      participant1Name: 'FoodieExplorer',
      participant2UID: _user2Id,
      participant2Name: 'WineEnthusiast',
      lastMessage: msg1,
      lastUpdated: msg1.timestamp,
      unreadCount: 1,
    );
    batch.set(conversations.doc(conv1Id), conv1.toJson());

    // Add message sub-doc
    batch.set(
      conversations.doc(conv1Id).collection(FirebaseCollections.messages).doc(msg1.id),
      msg1.toJson(),
    );

    await batch.commit();
    print('Seeded conversation between $_user1Id and $_user2Id');
  }

  /// Loads all users from Firestore and creates at least one conversation
  /// (with one message) per user by pairing consecutive users.
  /// Safe to call on every app start; skips existing conversations.
  Future<void> seedConversationsFromUsers() async {
    try {
      final usersSnap = await _firestore
          .collection(FirebaseCollections.users)
          .get();

      final users = <({String userUID, String userName})>[];
      for (final doc in usersSnap.docs) {
        final d = doc.data();
        final uid = d['userUID'] as String? ?? doc.id;
        final name = d['userName'] as String? ?? d['userEmail'] as String? ?? 'User';
        users.add((userUID: uid, userName: name));
      }

      if (users.length < 2) {
        return;
      }

      final now = DateTime.now();
      final convRef = _firestore.collection(FirebaseCollections.conversations);
      final created = <String>{};

      for (var i = 0; i < users.length; i++) {
        final userA = users[i];
        final userB = users[(i + 1) % users.length];
        final convId = _generateConversationId(userA.userUID, userB.userUID);
        if (created.contains(convId)) continue;
        created.add(convId);

        final existing = await convRef.doc(convId).get();
        if (existing.exists) continue;

        final msg = MessageModel(
          senderUID: userA.userUID,
          senderName: userA.userName,
          receiverUID: userB.userUID,
          receiverName: userB.userName,
          content: 'Hi ${userB.userName}! (seeded)',
          timestamp: now,
          isRead: false,
        );

        final ids = [userA.userUID, userB.userUID]..sort();
        final p1 = ids[0];
        final p2 = ids[1];
        final p1Name = p1 == userA.userUID ? userA.userName : userB.userName;
        final p2Name = p2 == userA.userUID ? userA.userName : userB.userName;
        final conv = ConversationModel(
          id: convId,
          participant1UID: p1,
          participant1Name: p1Name,
          participant2UID: p2,
          participant2Name: p2Name,
          lastMessage: msg,
          lastUpdated: msg.timestamp,
          unreadCount: 1,
        );

        final batch = _firestore.batch();
        batch.set(convRef.doc(convId), conv.toJson());
        batch.set(
          convRef.doc(convId).collection(FirebaseCollections.messages).doc(msg.id),
          msg.toJson(),
        );
        await batch.commit();
      }
    } catch (e) {
      print('seedConversationsFromUsers: $e');
    }
  }

  String _generateConversationId(String uid1, String uid2) {
    List<String> ids = [uid1, uid2];
    ids.sort();
    return ids.join('_');
  }
}
