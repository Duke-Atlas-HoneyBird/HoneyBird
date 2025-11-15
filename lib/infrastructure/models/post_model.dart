import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/post.dart';

/// Infrastructure model for Post entity with Firestore serialization.
/// 
/// Extends the domain Post entity and adds JSON serialization capabilities
/// with proper type conversions for Firebase Firestore integration.
/// Handles conversions between String/Uri and Timestamp/DateTime.
class PostModel extends Post {
  const PostModel({
    super.id,
    required super.text,
    super.imageURL,
    super.imageReferenceID = '',
    required super.publishedDate,
    super.upvoteIDs = const [],
    super.downvoteIDs = const [],
    required super.userName,
    required super.userUID,
  });

  /// Creates a PostModel from a JSON map (Firestore document).
  /// 
  /// Converts String to Uri for imageURL and Timestamp to DateTime for publishedDate.
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String?,
      text: json['text'] as String,
      imageURL: json['imageURL'] != null 
          ? Uri.parse(json['imageURL'] as String)
          : null,
      imageReferenceID: json['imageReferenceID'] as String? ?? '',
      publishedDate: (json['publishedDate'] as Timestamp).toDate(),
      upvoteIDs: List<String>.from(json['upvoteIDs'] as List? ?? []),
      downvoteIDs: List<String>.from(json['downvoteIDs'] as List? ?? []),
      userName: json['userName'] as String,
      userUID: json['userUID'] as String,
    );
  }

  /// Converts this PostModel to a JSON map for Firestore storage.
  /// 
  /// Converts Uri to String for imageURL and DateTime to Timestamp for publishedDate.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'imageURL': imageURL?.toString(),
      'imageReferenceID': imageReferenceID,
      'publishedDate': Timestamp.fromDate(publishedDate),
      'upvoteIDs': upvoteIDs,
      'downvoteIDs': downvoteIDs,
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
      publishedDate: post.publishedDate,
      upvoteIDs: post.upvoteIDs,
      downvoteIDs: post.downvoteIDs,
      userName: post.userName,
      userUID: post.userUID,
    );
  }
}
