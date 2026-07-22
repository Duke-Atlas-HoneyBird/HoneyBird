import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:honey_bird/core/utils/constants.dart';
import 'package:honey_bird/presentation/theme/colours.dart';
import 'package:honey_bird/presentation/theme/theme.dart';
import 'firebase_options.dart';
import 'core/di/injection.dart' as di;
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';
import 'presentation/bloc/feed/feed_bloc.dart';
import 'presentation/bloc/favorites/favorites_bloc.dart';
import 'presentation/bloc/account/account_bloc.dart';
import 'presentation/bloc/messages/messages_bloc.dart';
import 'presentation/bloc/timeline/timeline_bloc.dart';
import 'presentation/bloc/post/post_bloc.dart';
import 'presentation/bloc/profile/profile_bloc.dart';
import 'application/use_cases/post/get_posts.dart';
import 'domain/repositories/favorite_repository.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/repositories/block_repository.dart';
import 'presentation/router/app_router.dart';
import 'presentation/router/onboarding_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  // Fresh install: SharedPreferences wiped, iOS Keychain may keep auth.
  final prefs = di.sl<SharedPreferences>();
  if (prefs.getBool(StorageKeys.appHasLaunchedBefore) != true) {
    await FirebaseAuth.instance.signOut();
    await prefs.setBool(StorageKeys.appHasLaunchedBefore, true);
  }

  final authBloc = di.sl<AuthBloc>()
    ..add(const AuthEvent.checkRequested());

  runApp(HoneyBirdApp(authBloc: authBloc));
}

/// The root widget of the HoneyBird application
class HoneyBirdApp extends StatefulWidget {
  const HoneyBirdApp({super.key, required this.authBloc});

  final AuthBloc authBloc;

  @override
  State<HoneyBirdApp> createState() => _HoneyBirdAppState();
}

class _HoneyBirdAppState extends State<HoneyBirdApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createAppRouter(
      authBloc: widget.authBloc,
      onboardingSession: di.sl<OnboardingSession>(),
    );
  }

  @override
  void dispose() {
    _router.dispose();
    widget.authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: widget.authBloc),
        BlocProvider<FeedBloc>(
          create: (context) => FeedBloc(
            di.sl<GetPosts>(),
            postRepository: di.sl<PostRepository>(),
            favoriteRepository: di.sl<FavoriteRepository>(),
            blockRepository: di.sl<BlockRepository>(),
          ),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(
            favoriteRepository: di.sl<FavoriteRepository>(),
            postRepository: di.sl<PostRepository>(),
          ),
        ),
        BlocProvider<AccountBloc>(
          create: (context) => di.sl<AccountBloc>(),
        ),
        BlocProvider<MessagesBloc>(
          create: (context) => di.sl<MessagesBloc>(),
        ),
        BlocProvider<TimelineBloc>(
          create: (context) => TimelineBloc(
            di.sl<GetPosts>(),
            postRepository: di.sl<PostRepository>(),
            favoriteRepository: di.sl<FavoriteRepository>(),
            blockRepository: di.sl<BlockRepository>(),
          ),
        ),
        BlocProvider<PostBloc>(
          create: (context) => di.sl<PostBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => di.sl<ProfileBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'HoneyBird',
        debugShowCheckedModeBanner: false,
        color: primaryColor,
        theme: buildBlackAndWhiteTheme(),
        themeMode: ThemeMode.light,
        routerConfig: _router,
      ),
    );
  }
}
