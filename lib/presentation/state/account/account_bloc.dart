import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_preference.dart';
import 'account_event.dart';
import 'account_state.dart';

/// Bloc for managing account state and business logic
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(const AccountInitial()) {
    on<LoadAccountData>(_onLoadAccountData);
    on<UpdateUserPreferences>(_onUpdateUserPreferences);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  /// Generate dummy user data
  User _generateDummyUser() {
    return const User(
      id: 'user_account_1',
      userName: 'John Doe',
      userBio: 'Food enthusiast and travel lover. Always exploring new cuisines and experiences.',
      userBioLink: 'https://example.com/johndoe',
      userUID: 'user_account_1',
      userEmail: 'john.doe@example.com',
    );
  }

  /// Generate dummy user preferences
  UserPreference _generateDummyPreferences() {
    return const UserPreference(
      id: 'pref_account_1',
      halaal: false,
      haram: false,
      pork: false,
      vegan: false,
      vegetarian: true,
      lactose: false,
      outdoor: true,
      wineTasting: true,
      wineFarms: true,
      african: true,
      italian: true,
      greek: true,
      chinese: true,
      thai: true,
    );
  }

  Future<void> _onLoadAccountData(
    LoadAccountData event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountLoading());
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    try {
      final user = _generateDummyUser();
      final preferences = _generateDummyPreferences();
      emit(AccountLoaded(user: user, preferences: preferences));
    } catch (e) {
      emit(AccountError('Failed to load account data: ${e.toString()}'));
    }
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
      
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      try {
        emit(AccountLoaded(
          user: currentState.user,
          preferences: event.preferences,
        ));
      } catch (e) {
        emit(AccountError('Failed to update preferences: ${e.toString()}'));
      }
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
      
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      try {
        final updatedUser = User(
          id: currentState.user.id,
          userName: event.userName,
          userBio: event.userBio,
          userBioLink: event.userBioLink,
          userUID: currentState.user.userUID,
          userEmail: currentState.user.userEmail,
        );
        emit(AccountLoaded(
          user: updatedUser,
          preferences: currentState.preferences,
        ));
      } catch (e) {
        emit(AccountError('Failed to update profile: ${e.toString()}'));
      }
    }
  }
}

