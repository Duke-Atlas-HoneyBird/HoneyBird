import 'package:equatable/equatable.dart';
import '../../../domain/entities/post.dart';

/// Base class for Feed states
abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class FeedInitial extends FeedState {
  const FeedInitial();
}

/// Loading state
class FeedLoading extends FeedState {
  const FeedLoading();
}

/// Loaded state with posts
class FeedLoaded extends FeedState {
  final List<Post> posts;
  final String? selectedCategory;

  const FeedLoaded({
    required this.posts,
    this.selectedCategory,
  });

  @override
  List<Object?> get props => [posts, selectedCategory];
}

/// Error state
class FeedError extends FeedState {
  final String message;

  const FeedError(this.message);

  @override
  List<Object?> get props => [message];
}

