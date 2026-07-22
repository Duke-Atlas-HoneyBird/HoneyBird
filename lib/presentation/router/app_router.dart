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

  /// Screens that require a signed-in user.
  static const protected = <String>{
    createPost,
    favorites,
    account,
    messages,
    manage,
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

/// Builds the app [GoRouter] with onboarding + auth redirects.
GoRouter createAppRouter({
  required AuthBloc authBloc,
  required OnboardingSession onboardingSession,
}) {
  final refresh = Listenable.merge([
    GoRouterRefreshStream(authBloc.stream),
    onboardingSession,
  ]);

  return GoRouter(
    initialLocation: onboardingSession.completed
        ? AppRoutes.home
        : AppRoutes.onboarding,
    refreshListenable: refresh,
    redirect: (context, state) {
      final onboarded = onboardingSession.completed;
      final loc = state.matchedLocation;
      final loggingIn = loc == AppRoutes.auth;
      final onOnboarding = loc == AppRoutes.onboarding;
      final loggedIn = authBloc.state.user != null;
      final authLoading = authBloc.state.isLoading;

      // Fresh install: onboarding is the mandatory entry point.
      if (!onboarded && !onOnboarding) {
        return AppRoutes.onboarding;
      }
      if (onboarded && onOnboarding) {
        return AppRoutes.home;
      }

      // Wait for the initial auth check before bouncing to login.
      if (authLoading) {
        return null;
      }

      if (!loggedIn && AppRoutes.protected.contains(loc)) {
        return Uri(
          path: AppRoutes.auth,
          queryParameters: {'from': state.uri.toString()},
        ).toString();
      }

      if (loggedIn && loggingIn) {
        final from = state.uri.queryParameters['from'];
        if (from != null && from.isNotEmpty && from != AppRoutes.auth) {
          return from;
        }
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
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
