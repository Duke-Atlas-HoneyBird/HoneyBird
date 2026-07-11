import 'package:equatable/equatable.dart';
import '../../core/utils/uuid_utils.dart';

/// Domain entity representing a post in the system.
/// 
/// This entity is immutable and uses value equality for comparison.
/// Uses Uri for type safety with URLs and DateTime for proper date handling.
class Post extends Equatable {
  final String id;
  /// Caption — optional when post has image or video.
  final String text;
  final Uri? imageURL;
  final String imageReferenceID;
  final Uri? videoURL;
  final String videoReferenceID;
  final DateTime publishedDate;
  /// User IDs who starred (liked) this post — star = like in food context.
  final List<String> likeIDs;
  final String userName;
  final String userUID;
  /// Linked restaurant for B2C contact from this post.
  final String? restaurantId;
  final String? restaurantName;

  Post({
    String? id,
    this.text = '',
    this.imageURL,
    this.imageReferenceID = '',
    this.videoURL,
    this.videoReferenceID = '',
    required this.publishedDate,
    this.likeIDs = const [],
    required this.userName,
    required this.userUID,
    this.restaurantId,
    this.restaurantName,
  }) : id = id ?? UuidUtils.generate();

  bool get hasLinkedRestaurant =>
      (restaurantId?.isNotEmpty ?? false) &&
      (restaurantName?.isNotEmpty ?? false);

  @override
  List<Object?> get props => [
        id,
        text,
        imageURL,
        imageReferenceID,
        videoURL,
        videoReferenceID,
        publishedDate,
        likeIDs,
        userName,
        userUID,
        restaurantId,
        restaurantName,
      ];
}
