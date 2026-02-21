import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class PostsLoadRequested extends PostEvent {
  const PostsLoadRequested();
}

class PostCreateRequested extends PostEvent {
  final String text;
  final String? imageUrl;

  const PostCreateRequested({
    required this.text,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [text, imageUrl];
}

class PostLikeRequested extends PostEvent {
  final String postId;

  const PostLikeRequested({required this.postId});

  @override
  List<Object> get props => [postId];
}

class PostDeleteRequested extends PostEvent {
  final String postId;

  const PostDeleteRequested({required this.postId});

  @override
  List<Object> get props => [postId];
}