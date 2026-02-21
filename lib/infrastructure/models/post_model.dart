import '../../domain/entities/post.dart';

/// Infrastructure model for Post entity with Firestore serialization.
/// 
/// Extends the domain Post entity and adds JSON serialization capabilities
/// with proper type conversions for Firebase Firestore integration.
/// Handles conversions between String/Uri and Timestamp/DateTime.
class PostModel extends Post {
  PostModel({
    super.id,
    super.text = '',
    super.imageURL,
    super.imageReferenceID = '',
    super.videoURL,
    super.videoReferenceID = '',
    required super.publishedDate,
    super.likeIDs = const [],
    required super.userName,
    required super.userUID,
  });

  /// Parses Firestore publishedDate: ISO8601 string or Timestamp.
  static DateTime _parsePublishedDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return DateTime.now();
      }
    }
    if (value is DateTime) return value;
    // Firestore Timestamp has toDate()
    try {
      return (value as dynamic).toDate() as DateTime;
    } catch (_) {
      return DateTime.now();
    }
  }

  /// Creates a PostModel from a JSON map (Firestore document).
  /// Supports legacy upvoteIDs/downvoteIDs: merges into likeIDs for migration.
  factory PostModel.fromJson(Map<String, dynamic> json) {
    var likeIDs = List<String>.from(json['likeIDs'] as List? ?? []);
    if (likeIDs.isEmpty) {
      final up = List<String>.from(json['upvoteIDs'] as List? ?? []);
      likeIDs = up;
    }
    return PostModel(
      id: json['id'] as String?,
      text: json['text'] as String? ?? '',
      imageURL: json['imageURL'] != null
          ? Uri.parse(json['imageURL'] as String)
          : null,
      imageReferenceID: json['imageReferenceID'] as String? ?? '',
      videoURL: json['videoURL'] != null
          ? Uri.parse(json['videoURL'] as String)
          : null,
      videoReferenceID: json['videoReferenceID'] as String? ?? '',
      publishedDate: _parsePublishedDate(json['publishedDate']),
      likeIDs: likeIDs,
      userName: json['userName'] as String? ?? '',
      userUID: json['userUID'] as String? ?? '',
    );
  }

  /// Converts this PostModel to a JSON map for Firestore storage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'imageURL': imageURL?.toString(),
      'imageReferenceID': imageReferenceID,
      'videoURL': videoURL?.toString(),
      'videoReferenceID': videoReferenceID,
      'publishedDate': DateTime.now().toIso8601String(),
      'likeIDs': likeIDs,
      'userName': userName,
      'userUID': userUID,
    };
  }

  /// Creates a PostModel from a domain Post entity.
  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      text: post.text,
      imageURL: post.imageURL,
      imageReferenceID: post.imageReferenceID,
      videoURL: post.videoURL,
      videoReferenceID: post.videoReferenceID,
      publishedDate: post.publishedDate,
      likeIDs: post.likeIDs,
      userName: post.userName,
      userUID: post.userUID,
    );
  }

  /// Converts this PostModel to a domain Post entity.
  Post toDomain() {
    return Post(
      id: id,
      text: text,
      imageURL: imageURL,
      imageReferenceID: imageReferenceID,
      videoURL: videoURL,
      videoReferenceID: videoReferenceID,
      publishedDate: publishedDate,
      likeIDs: likeIDs,
      userName: userName,
      userUID: userUID,
    );
  }
}
