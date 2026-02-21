import 'package:equatable/equatable.dart';
import '../../../domain/entities/post.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {
  const PostInitial();
}

class PostLoading extends PostState {
  const PostLoading();
}

class PostsLoaded extends PostState {
  final List<Post> posts;

  const PostsLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostError extends PostState {
  final String message;

  const PostError({required this.message});

  @override
  List<Object> get props => [message];
}

class PostCreated extends PostState {
  final Post post;

  const PostCreated({required this.post});

  @override
  List<Object> get props => [post];
}

class PostUpdated extends PostState {
  final Post post;

  const PostUpdated({required this.post});

  @override
  List<Object> get props => [post];
}