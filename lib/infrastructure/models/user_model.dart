import '../../domain/entities/user.dart';

/// Infrastructure model for User entity with Firestore serialization.
/// 
/// Extends the domain User entity and adds JSON serialization capabilities
/// for Firebase Firestore integration.
class UserModel extends User {
  const UserModel({
    super.id,
    required super.userName,
    required super.userBio,
    required super.userBioLink,
    required super.userUID,
    required super.userEmail,
  });

  /// Creates a UserModel from a JSON map (Firestore document).
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      userName: json['userName'] as String,
      userBio: json['userBio'] as String,
      userBioLink: json['userBioLink'] as String,
      userUID: json['userUID'] as String,
      userEmail: json['userEmail'] as String,
    );
  }

  /// Converts this UserModel to a JSON map for Firestore storage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userBio': userBio,
      'userBioLink': userBioLink,
      'userUID': userUID,
      'userEmail': userEmail,
    };
  }

  /// Creates a UserModel from a domain User entity.
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      userName: user.userName,
      userBio: user.userBio,
      userBioLink: user.userBioLink,
      userUID: user.userUID,
      userEmail: user.userEmail,
    );
  }
}
