import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  final AuthRepository _authRepository;

  PostBloc({
    required PostRepository postRepository,
    required AuthRepository authRepository,
  })  : _postRepository = postRepository,
        _authRepository = authRepository,
        super(const PostInitial()) {
    on<PostsLoadRequested>(_onPostsLoadRequested);
    on<PostCreateRequested>(_onPostCreateRequested);
    on<PostLikeRequested>(_onPostLikeRequested);
    on<PostDeleteRequested>(_onPostDeleteRequested);
  }

  Future<void> _onPostsLoadRequested(
    PostsLoadRequested event,
    Emitter<PostState> emit,
  ) async {
    emit(const PostLoading());

    final result = await _postRepository.getPosts();

    result.fold(
      (failure) => emit(PostError(message: failure.message)),
      (posts) => emit(PostsLoaded(posts: posts)),
    );
  }

  Future<void> _onPostCreateRequested(
    PostCreateRequested event,
    Emitter<PostState> emit,
  ) async {
    emit(const PostLoading());

    // Get current user
    final userResult = await _authRepository.getCurrentUser();
    
    await userResult.fold(
      (failure) async => emit(PostError(message: 'Authentication required')),
      (user) async {
        if (user == null) {
          emit(const PostError(message: 'User not authenticated'));
          return;
        }

        final post = Post(
          text: event.text,
          imageURL: event.imageUrl != null ? Uri.parse(event.imageUrl!) : null,
          publishedDate: DateTime.now(),
          userName: user.displayName ?? user.email!.split('@').first,
          userUID: user.uid,
        );

        final result = await _postRepository.createPost(post);

        result.fold(
          (failure) => emit(PostError(message: failure.message)),
          (createdPost) => emit(PostCreated(post: createdPost)),
        );
      },
    );
  }

  Future<void> _onPostLikeRequested(
    PostLikeRequested event,
    Emitter<PostState> emit,
  ) async {
    final userResult = await _authRepository.getCurrentUser();

    await userResult.fold(
      (failure) async => emit(PostError(message: 'Authentication required')),
      (user) async {
        if (user == null) {
          emit(const PostError(message: 'User not authenticated'));
          return;
        }

        final result = await _postRepository.likePost(event.postId, user.uid);

        result.fold(
          (failure) => emit(PostError(message: failure.message)),
          (updatedPost) => emit(PostUpdated(post: updatedPost)),
        );
      },
    );
  }

  Future<void> _onPostDeleteRequested(
    PostDeleteRequested event,
    Emitter<PostState> emit,
  ) async {
    emit(const PostLoading());

    final result = await _postRepository.deletePost(event.postId);

    result.fold(
      (failure) => emit(PostError(message: failure.message)),
      (_) {
        // Reload posts after deletion
        add(const PostsLoadRequested());
      },
    );
  }
}