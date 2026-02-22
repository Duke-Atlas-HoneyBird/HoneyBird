import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_event.freezed.dart';

@freezed
class PostEvent with _$PostEvent {
  const factory PostEvent.loadRequested() = PostsLoadRequested;
  const factory PostEvent.createRequested({
    required String text,
    String? imageUrl,
    File? imageFile,
    File? videoFile,
  }) = PostCreateRequested;
  const factory PostEvent.likeRequested({required String postId}) =
      PostLikeRequested;
  const factory PostEvent.deleteRequested({required String postId}) =
      PostDeleteRequested;
}
