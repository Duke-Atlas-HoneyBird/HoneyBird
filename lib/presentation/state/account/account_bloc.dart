import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_preference.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/repositories/user_preference_repository.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository userRepository;
  final UserPreferenceRepository preferenceRepository;

  AccountBloc({
    required this.userRepository,
    required this.preferenceRepository,
  }) : super(const AccountState()) {
    on<LoadAccountData>(_onLoadAccountData);
    on<UpdateUserPreferences>(_onUpdateUserPreferences);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  Future<void> _onLoadAccountData(
    LoadAccountData event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final userResult = await userRepository.getUser(event.userUID);
    final prefResult = await preferenceRepository.getPreferences(event.userUID);

    userResult.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load user profile: ${failure.message}')),
      (user) {
        prefResult.fold(
          (failure) => emit(state.copyWith(
              isLoading: false,
              errorMessage:
                  'Failed to load user preferences: ${failure.message}')),
          (preferences) => emit(state.copyWith(
              isLoading: false, user: user, preferences: preferences)),
        );
      },
    );
  }

  Future<void> _onUpdateUserPreferences(
    UpdateUserPreferences event,
    Emitter<AccountState> emit,
  ) async {
    final user = state.user;
    final prefs = state.preferences;
    if (user == null || prefs == null) return;

    emit(state.copyWith(isSaving: true, errorMessage: null));

    final result = await preferenceRepository.savePreferences(event.preferences);

    result.fold(
      (failure) => emit(state.copyWith(
          isSaving: false,
          errorMessage: 'Failed to update preferences: ${failure.message}')),
      (_) => emit(state.copyWith(
          isSaving: false, preferences: event.preferences)),
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
          errorMessage: 'Failed to update profile: ${failure.message}')),
      (updated) => emit(state.copyWith(isSaving: false, user: updated)),
    );
  }
}
