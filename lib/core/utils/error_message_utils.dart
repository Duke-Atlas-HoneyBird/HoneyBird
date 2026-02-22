/// Utilities for safe, user-facing error messages.
/// Never expose IDs, paths, or technical details on the UI.
class ErrorMessageUtils {
  ErrorMessageUtils._();

  /// Returns a generic user-friendly message for display. Never includes IDs or technical details.
  static String forUi(String context) {
    switch (context) {
      case 'load_profile':
        return 'Could not load profile. Please try again.';
      case 'block':
        return 'Could not block user. Please try again.';
      case 'unblock':
        return 'Could not unblock user. Please try again.';
      case 'load_conversations':
        return 'Could not load conversations. Please try again.';
      case 'load_messages':
        return 'Could not load messages. Please try again.';
      case 'send_message':
        return 'Could not send message. Please try again.';
      case 'refresh_conversations':
        return 'Could not refresh. Please try again.';
      case 'load_timeline':
        return 'Could not load timeline. Please try again.';
      case 'refresh_timeline':
        return 'Could not refresh timeline. Please try again.';
      case 'load_more_timeline':
        return 'Could not load more. Please try again.';
      case 'update_timeline':
        return 'Could not update. Please try again.';
      case 'load_feed':
        return 'Could not load feed. Please try again.';
      case 'refresh_feed':
        return 'Could not refresh feed. Please try again.';
      case 'filter_feed':
        return 'Could not apply filter. Please try again.';
      case 'load_account':
        return 'Could not load profile. Please try again.';
      case 'load_preferences':
        return 'Could not load preferences. Please try again.';
      case 'save_preferences':
        return 'Could not save preferences. Please try again.';
      case 'save_profile':
        return 'Could not save profile. Please try again.';
      case 'auth':
        return 'Something went wrong. Please try again.';
      case 'post_create':
        return 'Could not create post. Please try again.';
      case 'load_posts':
        return 'Could not load posts. Please try again.';
      case 'comments':
        return 'Could not load comments. Please try again.';
      case 'comment_create':
        return 'Could not post comment. Please try again.';
      case 'tasks':
        return 'Could not load tasks. Please try again.';
      case 'tasks_save':
        return 'Could not save. Please try again.';
      case 'favorites':
        return 'Could not update. Please try again.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
