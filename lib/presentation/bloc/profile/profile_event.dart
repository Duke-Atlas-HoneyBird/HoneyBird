import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/post.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.loadUserProfile({
    required String targetUserUID,
    required String viewerUserUID,
  }) = LoadUserProfile;
  const factory ProfileEvent.likePostInProfile({
    required String postId,
    required String userUID,
  }) = LikePostInProfile;
  const factory ProfileEvent.addOrUpdatePostInProfile(Post post) =
      AddOrUpdatePostInProfile;
  const factory ProfileEvent.blockUser({
    required String currentUserUID,
    required String targetUserUID,
  }) = BlockUser;
  const factory ProfileEvent.unblockUser({
    required String currentUserUID,
    required String targetUserUID,
  }) = UnblockUser;
}
