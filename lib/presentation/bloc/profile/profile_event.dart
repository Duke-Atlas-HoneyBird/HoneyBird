import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.loadUserProfile({
    required String targetUserUID,
    required String viewerUserUID,
  }) = LoadUserProfile;
  const factory ProfileEvent.blockUser({
    required String currentUserUID,
    required String targetUserUID,
  }) = BlockUser;
  const factory ProfileEvent.unblockUser({
    required String currentUserUID,
    required String targetUserUID,
  }) = UnblockUser;
}
