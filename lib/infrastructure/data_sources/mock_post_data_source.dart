import '../../domain/entities/post.dart';
import '../models/post_model.dart';

/// Mock implementation of post data source for development/testing
/// This provides hardcoded data until Firebase is properly configured
abstract class MockPostDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPost(String postId);
  Future<PostModel> createPost(PostModel post);
  Future<PostModel> updatePost(PostModel post);
  Future<void> deletePost(String postId);
  Future<PostModel> likePost(String postId, String userId);
}

class MockPostDataSourceImpl implements MockPostDataSource {
  // In-memory storage for posts
  final List<Post> _posts = [];

  MockPostDataSourceImpl() {
    // Initialize with mock data
    final now = DateTime.now();
    _posts.addAll([
      Post(
        id: 'feed_1',
        text: 'Just discovered an amazing new restaurant in Cape Town! The food was incredible and the atmosphere was perfect for a date night. Highly recommend trying their signature dish!',
        publishedDate: now.subtract(const Duration(hours: 2)),
        userName: 'FoodieExplorer',
        userUID: 'user_feed_1',
        likeIDs: const ['user1', 'user2', 'user3', 'user4'],
      ),
      Post(
        id: 'feed_2',
        text: 'Wine tasting at a local vineyard was absolutely breathtaking. The sunset views paired with excellent wines made for an unforgettable experience. Perfect for wine lovers!',
        publishedDate: now.subtract(const Duration(hours: 5)),
        userName: 'WineEnthusiast',
        userUID: 'user_feed_2',
        likeIDs: const ['user1', 'user2', 'user3', 'user4', 'user5', 'user6'],
      ),
      Post(
        id: 'feed_3',
        text: 'Outdoor adventure at Table Mountain today! The hike was challenging but the views from the top were absolutely worth it. Nature never fails to amaze me.',
        publishedDate: now.subtract(const Duration(days: 1)),
        userName: 'AdventureSeeker',
        userUID: 'user_feed_3',
        likeIDs: const ['user1', 'user2', 'user3'],
      ),
      Post(
        id: 'feed_4',
        text: 'Tried authentic Italian cuisine at a hidden gem in the city. The pasta was handmade and the flavors were incredible. A must-visit for Italian food lovers!',
        publishedDate: now.subtract(const Duration(days: 1, hours: 3)),
        userName: 'ItalianFoodLover',
        userUID: 'user_feed_4',
        likeIDs: const ['user1', 'user2', 'user3', 'user4', 'user5'],
      ),
      Post(
        id: 'feed_5',
        text: 'Greek restaurant with amazing Mediterranean flavors! The moussaka was perfect and the atmosphere reminded me of my trip to Greece. Highly recommend!',
        publishedDate: now.subtract(const Duration(days: 2)),
        userName: 'MediterraneanFan',
        userUID: 'user_feed_5',
        likeIDs: const ['user1', 'user2'],
      ),
      Post(
        id: 'feed_6',
        text: 'Chinese dim sum experience was outstanding! The variety of dumplings and the authentic flavors made this one of my best dining experiences this year.',
        publishedDate: now.subtract(const Duration(days: 2, hours: 5)),
        userName: 'DimSumLover',
        userUID: 'user_feed_6',
        likeIDs: const ['user1', 'user2', 'user3', 'user4'],
      ),
      Post(
        id: 'feed_7',
        text: 'Thai street food market visit was incredible! The pad thai and green curry were authentic and delicious. Great place to explore different flavors!',
        publishedDate: now.subtract(const Duration(days: 3)),
        userName: 'ThaiFoodExplorer',
        userUID: 'user_feed_7',
        likeIDs: const ['user1', 'user2', 'user3'],
      ),
      Post(
        id: 'feed_8',
        text: 'African cuisine restaurant with traditional dishes was a cultural experience! The flavors were rich and authentic. Loved learning about the different regional cuisines.',
        publishedDate: now.subtract(const Duration(days: 4)),
        userName: 'CulturalFoodie',
        userUID: 'user_feed_8',
        likeIDs: const ['user1', 'user2', 'user3', 'user4', 'user5', 'user6', 'user7'],
      ),
    ]);
  }

  @override
  Future<List<PostModel>> getPosts() async {
    // Sort by published date descending
    final sortedPosts = List<Post>.from(_posts)
      ..sort((a, b) => b.publishedDate.compareTo(a.publishedDate));
    return sortedPosts.map((post) => PostModel.fromEntity(post)).toList();
  }

  @override
  Future<PostModel> getPost(String postId) async {
    final post = _posts.firstWhere(
      (p) => p.id == postId,
      orElse: () => throw Exception('Post not found with ID: $postId'),
    );
    return PostModel.fromEntity(post);
  }

  @override
  Future<PostModel> createPost(PostModel post) async {
    final newPost = Post(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      text: post.text,
      imageURL: post.imageURL,
      imageReferenceID: post.imageReferenceID,
      videoURL: post.videoURL,
      videoReferenceID: post.videoReferenceID,
      publishedDate: post.publishedDate,
      userName: post.userName,
      userUID: post.userUID,
      likeIDs: post.likeIDs,
    );
    _posts.add(newPost);
    return PostModel.fromEntity(newPost);
  }

  @override
  Future<PostModel> updatePost(PostModel post) async {
    final index = _posts.indexWhere((p) => p.id == post.id);
    if (index == -1) {
      throw Exception('Post not found with ID: ${post.id}');
    }
    _posts[index] = Post(
      id: post.id,
      text: post.text,
      imageURL: post.imageURL,
      imageReferenceID: post.imageReferenceID,
      videoURL: post.videoURL,
      videoReferenceID: post.videoReferenceID,
      publishedDate: post.publishedDate,
      userName: post.userName,
      userUID: post.userUID,
      likeIDs: post.likeIDs,
    );
    return post;
  }

  @override
  Future<void> deletePost(String postId) async {
    _posts.removeWhere((p) => p.id == postId);
  }

  @override
  Future<PostModel> likePost(String postId, String userId) async {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index == -1) {
      throw Exception('Post not found with ID: $postId');
    }

    final post = _posts[index];
    final likeIDs = List<String>.from(post.likeIDs);
    if (likeIDs.contains(userId)) {
      likeIDs.remove(userId);
    } else {
      likeIDs.add(userId);
    }

    _posts[index] = Post(
      id: post.id,
      text: post.text,
      imageURL: post.imageURL,
      imageReferenceID: post.imageReferenceID,
      publishedDate: post.publishedDate,
      userName: post.userName,
      userUID: post.userUID,
      likeIDs: likeIDs,
    );

    return PostModel.fromEntity(_posts[index]);
  }
}
