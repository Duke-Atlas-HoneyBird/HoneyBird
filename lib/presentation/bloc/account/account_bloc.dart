import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/error_message_utils.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/favorite_repository.dart';
import '../../../domain/repositories/post_repository.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/repositories/user_preference_repository.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository userRepository;
  final UserPreferenceRepository preferenceRepository;
  final PostRepository postRepository;
  final FavoriteRepository favoriteRepository;
  final SharedPreferences sharedPreferences;

  AccountBloc({
    required this.userRepository,
    required this.preferenceRepository,
    required this.postRepository,
    required this.favoriteRepository,
    required this.sharedPreferences,
  }) : super(const AccountState()) {
    on<LoadAccountData>(_onLoadAccountData);
    on<UpdateUserPreferences>(_onUpdateUserPreferences);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<CheckOnboardingStatus>(_onCheckOnboardingStatus);
    on<LikePostInAccount>(_onLikePostInAccount);
    on<AddOrUpdatePostInAccount>(_onAddOrUpdatePostInAccount);
  }

  Future<void> _onLoadAccountData(
    LoadAccountData event,
    Emitter<AccountState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        isLoadingPosts: true,
        errorMessage: null,
        hasCompletedOnboarding: sharedPreferences
                .getBool(StorageKeys.hasCompletedOnboardingThisInstall) ??
            false,
      ),
    );

    final userResult = await userRepository.getUser(event.userUID);
    final prefResult = await preferenceRepository.getPreferences(event.userUID);
    final postsResult = await postRepository.getPostsByUserUID(event.userUID);

    final posts = postsResult.fold((_) => <Post>[], (list) => list);

    userResult.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          isLoadingPosts: false,
          errorMessage: ErrorMessageUtils.forUi('load_account'))),
      (user) {
        prefResult.fold(
          (failure) => emit(state.copyWith(
              isLoading: false,
              isLoadingPosts: false,
              posts: posts,
              errorMessage: ErrorMessageUtils.forUi('load_preferences'))),
          (preferences) => emit(state.copyWith(
                isLoading: false,
                isLoadingPosts: false,
                user: user,
                preferences: preferences,
                posts: posts,
              )),
        );
      },
    );
  }

  Future<void> _onUpdateUserPreferences(
    UpdateUserPreferences event,
    Emitter<AccountState> emit,
  ) async {
    final user = state.user;
    if (user == null) return;

    emit(state.copyWith(isSaving: true, errorMessage: null));

    // Only set hasCompletedOnboardingThisInstall in DB when user actually completes onboarding
    final prefsToSave = event.markOnboardingComplete
        ? event.preferences.copyWith(hasCompletedOnboardingThisInstall: true)
        : event.preferences;

    final result = await preferenceRepository.savePreferences(prefsToSave);

    await result.fold(
      (failure) async => emit(state.copyWith(
          isSaving: false,
          errorMessage: ErrorMessageUtils.forUi('save_preferences'))),
      (_) async {
        if (event.markOnboardingComplete) {
          await sharedPreferences.setBool(
              StorageKeys.hasCompletedOnboardingThisInstall, true);
        }
        emit(state.copyWith(isSaving: false, preferences: prefsToSave));
      },
    );
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<AccountState> emit,
  ) async {
    final currentUser = state.user;
    final prefs = state.preferences;
    if (currentUser == null || prefs == null) return;

    emit(state.copyWith(isSaving: true, errorMessage: null));

    final updatedUser = User(
      id: currentUser.id,
      userName: event.userName,
      userBio: event.userBio,
      userBioLink: event.userBioLink,
      userUID: currentUser.userUID,
      userEmail: currentUser.userEmail,
    );

    final result = await userRepository.updateUser(updatedUser);

    result.fold(
      (failure) => emit(state.copyWith(
          isSaving: false,
          errorMessage: ErrorMessageUtils.forUi('save_profile'))),
      (updated) => emit(state.copyWith(isSaving: false, user: updated)),
    );
  }

  Future<void> _onCheckOnboardingStatus(
    CheckOnboardingStatus event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // DB is source of truth; sync local store to match
    final prefResult = await preferenceRepository.getPreferences(event.userUID);

    await prefResult.fold(
      (failure) async {
        await sharedPreferences.setBool(
            StorageKeys.hasCompletedOnboardingThisInstall, false);
        emit(state.copyWith(isLoading: false, hasCompletedOnboarding: false));
      },
      (preferences) async {
        final hasCompleted = preferences.hasCompletedOnboardingThisInstall;
        await sharedPreferences.setBool(
            StorageKeys.hasCompletedOnboardingThisInstall, hasCompleted);
        emit(state.copyWith(
            isLoading: false, hasCompletedOnboarding: hasCompleted));
      },
    );
  }

  Future<void> _onLikePostInAccount(
    LikePostInAccount event,
    Emitter<AccountState> emit,
  ) async {
    final result =
        await postRepository.likePost(event.postId, event.userUID);

    await result.fold(
      (failure) async => emit(state.copyWith(
          errorMessage: ErrorMessageUtils.forUi('favorites'))),
      (updatedPost) async {
        if (updatedPost.likeIDs.contains(event.userUID)) {
          await favoriteRepository.addToFavorites(event.postId, event.userUID);
        } else {
          await favoriteRepository.removeFromFavorites(
              event.postId, event.userUID);
        }
        add(AccountEvent.addOrUpdatePostInAccount(updatedPost));
      },
    );
  }

  FutureOr<void> _onAddOrUpdatePostInAccount(
    AddOrUpdatePostInAccount event,
    Emitter<AccountState> emit,
  ) {
    final updatedPosts = state.posts.map((post) {
      return post.id == event.post.id ? event.post : post;
    }).toList();
    emit(state.copyWith(posts: updatedPosts, errorMessage: null));
  }
}
