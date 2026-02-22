import '../../domain/entities/comment.dart';

/// Infrastructure model for Comment entity with Firestore serialization.
///
/// Extends the domain Comment entity and adds JSON serialization
/// for Firebase Firestore integration.
class CommentModel extends Comment {
  CommentModel({
    super.id,
    required super.postId,
    required super.text,
    required super.publishedDate,
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
    try {
      return (value as dynamic).toDate() as DateTime;
    } catch (_) {
      return DateTime.now();
    }
  }

  /// Creates a CommentModel from a JSON map (Firestore document).
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String?,
      postId: json['postId'] as String? ?? '',
      text: json['text'] as String? ?? '',
      publishedDate: _parsePublishedDate(json['publishedDate']),
      userName: json['userName'] as String? ?? '',
      userUID: json['userUID'] as String? ?? '',
    );
  }

  /// Converts this CommentModel to a JSON map for Firestore storage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'text': text,
      'publishedDate': publishedDate.toIso8601String(),
      'userName': userName,
      'userUID': userUID,
    };
  }

  /// Creates a CommentModel from a domain Comment entity.
  factory CommentModel.fromEntity(Comment comment) {
    return CommentModel(
      id: comment.id,
      postId: comment.postId,
      text: comment.text,
      publishedDate: comment.publishedDate,
      userName: comment.userName,
      userUID: comment.userUID,
    );
  }

  /// Converts this CommentModel to a domain Comment entity.
  Comment toDomain() {
    return Comment(
      id: id,
      postId: postId,
      text: text,
      publishedDate: publishedDate,
      userName: userName,
      userUID: userUID,
    );
  }
}
