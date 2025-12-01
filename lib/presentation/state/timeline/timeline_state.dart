import 'package:equatable/equatable.dart';
import '../../../domain/entities/post.dart';

/// Base class for Timeline states
abstract class TimelineState extends Equatable {
  const TimelineState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class TimelineInitial extends TimelineState {
  const TimelineInitial();
}

/// Loading state
class TimelineLoading extends TimelineState {
  const TimelineLoading();
}

/// Loaded state with posts
class TimelineLoaded extends TimelineState {
  final List<Post> posts;
  final bool hasMore;
  final bool isLoadingMore;

  const TimelineLoaded({
    required this.posts,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [posts, hasMore, isLoadingMore];

  TimelineLoaded copyWith({
    List<Post>? posts,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return TimelineLoaded(
      posts: posts ?? this.posts,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

/// Error state
class TimelineError extends TimelineState {
  final String message;

  const TimelineError(this.message);

  @override
  List<Object?> get props => [message];
}

