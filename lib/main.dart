import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:honey_bird/core/utils/constants.dart';
import 'package:honey_bird/presentation/theme/colours.dart';
import 'package:honey_bird/presentation/theme/theme.dart';
import 'firebase_options.dart';
import 'core/di/injection.dart' as di;
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/favorites_screen.dart';
import 'presentation/screens/messages_screen.dart';
import 'presentation/screens/account_screen.dart';
import 'presentation/screens/manage_screen.dart';
import 'presentation/screens/timeline_screen.dart';
import 'presentation/screens/feed_screen.dart';
import 'presentation/screens/user_profile_screen.dart';
import 'presentation/bloc/profile/profile_bloc.dart';
import 'presentation/widgets/post_auth_gate.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';
import 'presentation/bloc/auth/auth_state.dart';
import 'presentation/bloc/feed/feed_bloc.dart';
import 'presentation/bloc/favorites/favorites_bloc.dart';
import 'presentation/bloc/account/account_bloc.dart';
import 'presentation/bloc/messages/messages_bloc.dart';
import 'presentation/bloc/timeline/timeline_bloc.dart';
import 'presentation/bloc/post/post_bloc.dart';
import 'application/use_cases/post/get_posts.dart';
import 'domain/repositories/favorite_repository.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/repositories/block_repository.dart';
import 'presentation/screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize dependency injection
  await di.init();

  // On fresh install (app delete or clear data): sign out to clear any persisted auth.
  // iOS Keychain persists across reinstalls; SharedPreferences is wiped.
  final prefs = di.sl<SharedPreferences>();
  if (prefs.getBool(StorageKeys.appHasLaunchedBefore) != true) {
    await FirebaseAuth.instance.signOut();
    await prefs.setBool(StorageKeys.appHasLaunchedBefore, true);
  }

  runApp(const HoneyBirdApp());
}

/// The root widget of the HoneyBird application
class HoneyBirdApp extends StatelessWidget {
  const HoneyBirdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>()..add(const AuthEvent.checkRequested()),
        ),
        BlocProvider<FeedBloc>(
          create: (_) => FeedBloc(
            di.sl<GetPosts>(),
            postRepository: di.sl<PostRepository>(),
            favoriteRepository: di.sl<FavoriteRepository>(),
            blockRepository: di.sl<BlockRepository>(),
          ),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) => FavoritesBloc(
            favoriteRepository: di.sl<FavoriteRepository>(),
            postRepository: di.sl<PostRepository>(),
          ),
        ),
        BlocProvider<AccountBloc>(
          create: (_) => di.sl<AccountBloc>(),
        ),
        BlocProvider<MessagesBloc>(
          create: (_) => di.sl<MessagesBloc>(),
        ),
        BlocProvider<TimelineBloc>(
          create: (_) => TimelineBloc(
            di.sl<GetPosts>(),
            postRepository: di.sl<PostRepository>(),
            favoriteRepository: di.sl<FavoriteRepository>(),
            blockRepository: di.sl<BlockRepository>(),
          ),
        ),
        BlocProvider<PostBloc>(
          create: (_) => di.sl<PostBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => di.sl<ProfileBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'HoneyBird',
        debugShowCheckedModeBanner: false,
        color: primaryColor,
        theme: buildBlackAndWhiteTheme(),
        themeMode: ThemeMode.light,
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          buildWhen: (prev, curr) =>
              prev.user != curr.user || prev.errorMessage != curr.errorMessage,
          builder: (context, state) {
            if (state.user != null) {
              return const PostAuthGate();
            }
            if (state.user == null && !state.isLoading) {
              return const AuthScreen();
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        routes: {
          '/auth': (_) => const AuthScreen(),
          '/home': (_) => const HomeScreen(),
          '/favorites': (_) => const FavoritesScreen(),
          '/messages': (_) => MessagesScreen(key: messagesScreenGlobalKey),
          '/account': (_) => const AccountScreen(),
          '/manage': (_) => const ManageScreen(),
          '/timeline': (_) => const TimelineScreen(),
          '/feed': (_) => const FeedScreen(),
          '/profile': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
            final userUID = args?['userUID'];
            final userName = args?['userName'] ?? '';
            if (userUID == null || userName.isEmpty) {
              return const Scaffold(body: Center(child: Text('Invalid profile')));
            }
            return BlocProvider(
              create: (_) => di.sl<ProfileBloc>(),
              child: UserProfileScreen(
                targetUserUID: userUID,
                targetUserName: userName,
              ),
            );
          },
        },
      ),
    );
  }
}
