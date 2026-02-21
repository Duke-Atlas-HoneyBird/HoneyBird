import '../../domain/entities/user.dart';
import '../models/user_model.dart';

/// Mock implementation of user data source for development/testing
/// This provides hardcoded data until Firebase is properly configured
abstract class MockUserDataSource {
  Future<UserModel> getUser(String userId);
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> updateUser(UserModel user);
  Future<void> deleteUser(String userId);
}

class MockUserDataSourceImpl implements MockUserDataSource {
  // In-memory storage for users
  final Map<String, User> _users = {};

  MockUserDataSourceImpl() {
    // Initialize with mock data
    _users['user_feed_1'] = User(
      id: 'user_feed_1',
      userName: 'FoodieExplorer',
      userBio: 'Food enthusiast exploring Cape Town',
      userBioLink: 'https://example.com/foodie',
      userUID: 'user_feed_1',
      userEmail: 'foodie@example.com',
    );
    _users['user_feed_2'] = User(
      id: 'user_feed_2',
      userName: 'WineEnthusiast',
      userBio: 'Wine lover and vineyard explorer',
      userBioLink: 'https://example.com/wine',
      userUID: 'user_feed_2',
      userEmail: 'wine@example.com',
    );
  }

  @override
  Future<UserModel> getUser(String userId) async {
    final user = _users[userId];
    if (user == null) {
      throw Exception('User not found with ID: $userId');
    }
    return UserModel.fromEntity(user);
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    final newUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      userName: user.userName,
      userBio: user.userBio,
      userBioLink: user.userBioLink,
      userUID: user.userUID,
      userEmail: user.userEmail,
    );
    _users[newUser.id] = newUser;
    return UserModel.fromEntity(newUser);
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    if (user.id == null || !_users.containsKey(user.id)) {
      throw Exception('User not found with ID: ${user.id}');
    }
    final updatedUser = User(
      id: user.id,
      userName: user.userName,
      userBio: user.userBio,
      userBioLink: user.userBioLink,
      userUID: user.userUID,
      userEmail: user.userEmail,
    );
    _users[user.id] = updatedUser;
    return user;
  }

  @override
  Future<void> deleteUser(String userId) async {
    _users.remove(userId);
  }
}
