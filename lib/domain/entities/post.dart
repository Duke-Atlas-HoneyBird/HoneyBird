import 'package:equatable/equatable.dart';

/// Domain entity representing a post in the system.
/// 
/// This entity is immutable and uses value equality for comparison.
/// Uses Uri for type safety with URLs and DateTime for proper date handling.
class Post extends Equatable {
  final String? id;
  final String text;
  final Uri? imageURL;
  final String imageReferenceID;
  final DateTime publishedDate;
  final List<String> upvoteIDs;
  final List<String> downvoteIDs;
  final String userName;
  final String userUID;

  const Post({
    this.id,
    required this.text,
    this.imageURL,
    this.imageReferenceID = '',
    required this.publishedDate,
    this.upvoteIDs = const [],
    this.downvoteIDs = const [],
    required this.userName,
    required this.userUID,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        imageURL,
        imageReferenceID,
        publishedDate,
        upvoteIDs,
        downvoteIDs,
        userName,
        userUID,
      ];
}
