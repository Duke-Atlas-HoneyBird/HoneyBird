/// Firebase collection names
class FirebaseCollections {
  static const String posts = 'posts';
  static const String users = 'users';
  static const String messages = 'messages';
  static const String tasks = 'tasks';
  static const String favorites = 'favorites';
  static const String preferences = 'preferences';
  static const String conversations = 'conversations';
  static const String comments = 'comments';
  static const String blocked = 'blocked';
  static const String restaurants = 'restaurants';
}

/// Firebase storage paths
class FirebaseStoragePaths {
  static const String postImages = 'post_images';
  static const String postVideos = 'post_videos';
  static const String userAvatars = 'user_avatars';
}

/// App constants
class AppConstants {
  static const String appName = 'Honey Bird';
  static const int postsPerPage = 20;
  static const int maxImageSizeMB = 5;
}

/// Local storage keys
class StorageKeys {
  static const String tasks = 'tasks';
  static const String userPreferences = 'user_preferences';
  /// Set when user completes onboarding. Wiped on app uninstall = fresh start.
  static const String hasCompletedOnboardingThisInstall = 'has_completed_onboarding_this_install';
  /// Set on first app launch. If missing = fresh install → sign out to clear any Keychain-persisted auth.
  static const String appHasLaunchedBefore = 'app_has_launched_before';
}