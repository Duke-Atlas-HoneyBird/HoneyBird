import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart' as di;
import '../bloc/auth/auth_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../screens/account_screen.dart';
import '../screens/auth_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/home_screen.dart';
import '../screens/legal_document_screen.dart';
import '../screens/manage_screen.dart';
import '../screens/messages_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/post_creation_screen.dart';
import '../screens/timeline_screen.dart';
import '../screens/user_profile_screen.dart';
import 'onboarding_session.dart';
import 'router_refresh.dart';

/// Route path constants.
abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const boot = '/boot';
  static const home = '/home';
  static const auth = '/auth';
  static const createPost = '/create-post';
  static const favorites = '/favorites';
  static const account = '/account';
  static const messages = '/messages';
  static const manage = '/manage';
  static const timeline = '/timeline';
  static const feed = '/feed';
  static const profile = '/profile';
  static const privacy = '/privacy';
  static const terms = '/terms';
  static const deleteAccount = '/delete';
  static const communityGuidelines = '/community-guidelines';

  static const publicDocuments = <String>{
    privacy,
    terms,
    deleteAccount,
    communityGuidelines,
  };

  static void goTab(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(home);
      case 1:
        context.go(favorites);
      case 2:
        context.go(account);
      case 3:
        context.go(messages);
    }
  }

  static String profileLocation(String userUID, String userName) {
    return Uri(
      path: '$profile/$userUID',
      queryParameters: {'userName': userName},
    ).toString();
  }
}

/// True when [from] is an in-app path we can return to after sign-in.
bool _isSafeReturnPath(String from) {
  return from.startsWith('/') &&
      !from.startsWith('//') &&
      !from.startsWith(AppRoutes.auth) &&
      !from.startsWith(AppRoutes.boot) &&
      !from.startsWith(AppRoutes.onboarding);
}

/// Builds the app [GoRouter].
///
/// Fresh install: preferences, then sign-in. Every other screen requires an account.
GoRouter createAppRouter({
  required AuthBloc authBloc,
  required OnboardingSession onboardingSession,
}) {
  final refresh = Listenable.merge([
    GoRouterRefreshStream(authBloc.stream),
    onboardingSession,
  ]);

  return GoRouter(
    initialLocation:
        onboardingSession.completed ? AppRoutes.boot : AppRoutes.onboarding,
    refreshListenable: refresh,
    redirect: (context, state) {
      final onboarded = onboardingSession.completed;
      final loc = state.matchedLocation;
      final loggedIn = authBloc.state.user != null;
      final authLoading = authBloc.state.isLoading;

      // Store and web links must open without an account.
      if (AppRoutes.publicDocuments.contains(loc)) {
        return null;
      }

      // Preferences always come before the rest of the app.
      if (!onboarded) {
        return loc == AppRoutes.onboarding ? null : AppRoutes.onboarding;
      }

      // Hold the splash until the session check finishes so taste choices
      // saved before auth are applied before Home opens.
      // Sign-in sets loading too, and that stays on the auth screen.
      if (authLoading && loc != AppRoutes.auth) {
        return loc == AppRoutes.boot ? null : AppRoutes.boot;
      }

      if (loggedIn) {
        if (loc == AppRoutes.auth) {
          final from = state.uri.queryParameters['from'];
          if (from != null && _isSafeReturnPath(from)) return from;
        }
        if (loc == AppRoutes.auth ||
            loc == AppRoutes.boot ||
            loc == AppRoutes.onboarding) {
          return AppRoutes.home;
        }
        return null;
      }

      if (loc == AppRoutes.auth) return null;

      if (loc == AppRoutes.boot || loc == AppRoutes.onboarding) {
        return AppRoutes.auth;
      }

      return Uri(
        path: AppRoutes.auth,
        queryParameters: {'from': state.uri.toString()},
      ).toString();
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.boot,
        builder: (context, state) => const _SessionGate(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.createPost,
        builder: (context, state) => const PostCreationScreen(),
      ),
      GoRoute(
        path: AppRoutes.favorites,
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: AppRoutes.account,
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.messages,
        builder: (context, state) =>
            MessagesScreen(key: messagesScreenGlobalKey),
      ),
      GoRoute(
        path: AppRoutes.manage,
        builder: (context, state) => const ManageScreen(),
      ),
      GoRoute(
        path: AppRoutes.timeline,
        builder: (context, state) => const TimelineScreen(),
      ),
      GoRoute(
        path: AppRoutes.feed,
        builder: (context, state) => const FeedScreen(),
      ),
      GoRoute(
        path: AppRoutes.privacy,
        builder: (context, state) => const LegalDocumentScreen(
          assetPath: 'assets/docs/privacy.md',
        ),
      ),
      GoRoute(
        path: AppRoutes.terms,
        builder: (context, state) => const LegalDocumentScreen(
          assetPath: 'assets/docs/terms.md',
        ),
      ),
      GoRoute(
        path: AppRoutes.deleteAccount,
        builder: (context, state) => const LegalDocumentScreen(
          assetPath: 'assets/docs/delete.md',
        ),
      ),
      GoRoute(
        path: AppRoutes.communityGuidelines,
        builder: (context, state) => const LegalDocumentScreen(
          assetPath: 'assets/docs/community_guidelines.md',
        ),
      ),
      GoRoute(
        path: '${AppRoutes.profile}/:userUID',
        builder: (context, state) {
          final userUID = state.pathParameters['userUID'];
          final userName = state.uri.queryParameters['userName'];
          if (userUID == null || userUID.isEmpty || userName == null) {
            return const Scaffold(
              body: Center(child: Text('Invalid profile')),
            );
          }
          return BlocProvider(
            create: (_) => di.sl<ProfileBloc>(),
            child: UserProfileScreen(
              targetUserUID: userUID,
              targetUserName: userName,
            ),
          );
        },
      ),
    ],
  );
}

/// Shown while the first auth check finishes, before home or sign-in.
class _SessionGate extends StatelessWidget {
  const _SessionGate();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
