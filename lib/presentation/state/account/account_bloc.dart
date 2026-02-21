import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_preference.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/repositories/user_preference_repository.dart';
import 'account_event.dart';
import 'account_state.dart';

/// Bloc for managing account state and business logic
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository userRepository;
  final UserPreferenceRepository preferenceRepository;

  AccountBloc({
    required this.userRepository,
    required this.preferenceRepository,
  }) : super(const AccountInitial()) {
    on<LoadAccountData>(_onLoadAccountData);
    on<UpdateUserPreferences>(_onUpdateUserPreferences);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  Future<void> _onLoadAccountData(
    LoadAccountData event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountLoading());
    
    final userResult = await userRepository.getUser(event.userUID);
    final prefResult = await preferenceRepository.getPreferences(event.userUID);

    userResult.fold(
      (failure) => emit(AccountError('Failed to load user profile: ${failure.message}')),
      (user) {
        prefResult.fold(
          (failure) => emit(AccountError('Failed to load user preferences: ${failure.message}')),
          (preferences) => emit(AccountLoaded(user: user, preferences: preferences)),
        );
      },
    );
  }

  Future<void> _onUpdateUserPreferences(
    UpdateUserPreferences event,
    Emitter<AccountState> emit,
  ) async {
    final currentState = state;
    if (currentState is AccountLoaded) {
      emit(AccountSaving(
        user: currentState.user,
        preferences: event.preferences,
      ));
      
      final result = await preferenceRepository.savePreferences(event.preferences);
      
      result.fold(
        (failure) => emit(AccountError('Failed to update preferences: ${failure.message}')),
        (_) => emit(AccountLoaded(
          user: currentState.user,
          preferences: event.preferences,
        )),
      );
    }
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<AccountState> emit,
  ) async {
    final currentState = state;
    if (currentState is AccountLoaded) {
      emit(AccountSaving(
        user: currentState.user,
        preferences: currentState.preferences,
      ));
      
      final updatedUser = User(
        id: currentState.user.id,
        userName: event.userName,
        userBio: event.userBio,
        userBioLink: event.userBioLink,
        userUID: currentState.user.userUID,
        userEmail: currentState.user.userEmail,
      );

      final result = await userRepository.updateUser(updatedUser);
      
      result.fold(
        (failure) => emit(AccountError('Failed to update profile: ${failure.message}')),
        (updated) => emit(AccountLoaded(
          user: updated,
          preferences: currentState.preferences,
        )),
      );
    }
  }
}

