import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_preference.dart';

/// Base class for Account events
abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load account data
class LoadAccountData extends AccountEvent {
  const LoadAccountData();
}

/// Event to update user preferences
class UpdateUserPreferences extends AccountEvent {
  final UserPreference preferences;

  const UpdateUserPreferences(this.preferences);

  @override
  List<Object?> get props => [preferences];
}

/// Event to update user profile
class UpdateUserProfile extends AccountEvent {
  final String userName;
  final String userBio;
  final String userBioLink;

  const UpdateUserProfile({
    required this.userName,
    required this.userBio,
    required this.userBioLink,
  });

  @override
  List<Object?> get props => [userName, userBio, userBioLink];
}

