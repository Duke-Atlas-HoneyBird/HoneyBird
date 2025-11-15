import 'package:equatable/equatable.dart';

/// Domain entity representing a user in the system.
/// 
/// This entity is immutable and uses value equality for comparison.
/// The id is nullable to support creation before persistence.
class User extends Equatable {
  final String? id;
  final String userName;
  final String userBio;
  final String userBioLink;
  final String userUID;
  final String userEmail;

  const User({
    this.id,
    required this.userName,
    required this.userBio,
    required this.userBioLink,
    required this.userUID,
    required this.userEmail,
  });

  @override
  List<Object?> get props => [
        id,
        userName,
        userBio,
        userBioLink,
        userUID,
        userEmail,
      ];
}
