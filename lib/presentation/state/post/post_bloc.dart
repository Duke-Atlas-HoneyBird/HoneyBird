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
        super(const PostState()) {
    on<PostsLoadRequested>(_onPostsLoadRequested);
    on<PostCreateRequested>(_onPostCreateRequested);
    on<PostLikeRequested>(_onPostLikeRequested);
    on<PostDeleteRequested>(_onPostDeleteRequested);
  }

  Future<void> _onPostsLoadRequested(
    PostsLoadRequested event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _postRepository.getPosts();

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: failure.message, posts: [])),
      (posts) => emit(state.copyWith(isLoading: false, posts: posts)),
    );
  }

  Future<void> _onPostCreateRequested(
    PostCreateRequested event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final userResult = await _authRepository.getCurrentUser();

    await userResult.fold(
      (failure) async => emit(state.copyWith(
          isLoading: false, errorMessage: 'Authentication required')),
      (user) async {
        if (user == null) {
          emit(state.copyWith(
              isLoading: false, errorMessage: 'User not authenticated'));
          return;
        }

        final post = Post(
          text: event.text,
          imageURL: event.imageUrl != null ? Uri.parse(event.imageUrl!) : null,
          publishedDate: DateTime.now(),
          userName: user.displayName ?? user.email.split('@').first,
          userUID: user.uid,
        );

        final result = await _postRepository.createPost(post);

        result.fold(
          (failure) => emit(state.copyWith(
              isLoading: false, errorMessage: failure.message)),
          (createdPost) => emit(state.copyWith(
              isLoading: false, lastCreatedPost: createdPost)),
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
      (failure) async => emit(state.copyWith(errorMessage: 'Authentication required')),
      (user) async {
        if (user == null) {
          emit(state.copyWith(errorMessage: 'User not authenticated'));
          return;
        }

        final result = await _postRepository.likePost(event.postId, user.uid);

        result.fold(
          (failure) => emit(state.copyWith(errorMessage: failure.message)),
          (updatedPost) => emit(state.copyWith(lastUpdatedPost: updatedPost)),
        );
      },
    );
  }

  Future<void> _onPostDeleteRequested(
    PostDeleteRequested event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _postRepository.deletePost(event.postId);

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: failure.message)),
      (_) {
        add(const PostEvent.loadRequested());
      },
    );
  }
}
