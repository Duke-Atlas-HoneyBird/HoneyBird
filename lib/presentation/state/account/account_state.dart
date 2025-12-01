import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_preference.dart';

/// Base class for Account states
abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AccountInitial extends AccountState {
  const AccountInitial();
}

/// Loading state
class AccountLoading extends AccountState {
  const AccountLoading();
}

/// Loaded state with user data
class AccountLoaded extends AccountState {
  final User user;
  final UserPreference preferences;

  const AccountLoaded({
    required this.user,
    required this.preferences,
  });

  @override
  List<Object?> get props => [user, preferences];
}

/// Error state
class AccountError extends AccountState {
  final String message;

  const AccountError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Saving state
class AccountSaving extends AccountState {
  final User user;
  final UserPreference preferences;

  const AccountSaving({
    required this.user,
    required this.preferences,
  });

  @override
  List<Object?> get props => [user, preferences];
}

