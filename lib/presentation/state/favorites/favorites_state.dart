import 'package:equatable/equatable.dart';
import '../../../domain/entities/post.dart';

/// Base class for Favorites states
abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

/// Loading state
class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

/// Loaded state with favorite posts
class FavoritesLoaded extends FavoritesState {
  final List<Post> posts;

  const FavoritesLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

/// Error state
class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}

