import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'presentation/widgets/post_auth_gate.dart';
import 'presentation/state/auth/auth_bloc.dart';
import 'presentation/state/auth/auth_event.dart';
import 'presentation/state/auth/auth_state.dart';
import 'presentation/state/feed/feed_bloc.dart';
import 'presentation/state/favorites/favorites_bloc.dart';
import 'presentation/state/account/account_bloc.dart';
import 'presentation/state/messages/messages_bloc.dart';
import 'presentation/state/timeline/timeline_bloc.dart';
import 'application/use_cases/post/get_posts.dart';
import 'domain/repositories/favorite_repository.dart';
import 'presentation/screens/auth_screen.dart';
import 'core/utils/data_seeder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize dependency injection
  await di.init();

  // Seed conversations from existing users (runs in background; safe to call every launch)
  // DataSeeder().seedConversationsFromUsers();

  // Uncomment the line below to seed Firestore with full dummy data
  // await DataSeeder().seedFirestore();

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
          create: (context) => di.sl<AuthBloc>()..add(const AuthEvent.checkRequested()),
        ),
        BlocProvider<FeedBloc>(
          create: (context) => FeedBloc(di.sl<GetPosts>()),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(favoriteRepository: di.sl<FavoriteRepository>()),
        ),
        BlocProvider<AccountBloc>(
          create: (context) => di.sl<AccountBloc>(),
        ),
        BlocProvider<MessagesBloc>(
          create: (context) => di.sl<MessagesBloc>(),
        ),
        BlocProvider<TimelineBloc>(
          create: (context) => TimelineBloc(di.sl<GetPosts>()),
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
              prev?.user != curr.user || prev?.errorMessage != curr.errorMessage,
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
          '/auth': (context) => const AuthScreen(),
          '/home': (context) => const HomeScreen(),
          '/favorites': (context) => const FavoritesScreen(),
          '/messages': (context) => const MessagesScreen(),
          '/account': (context) => const AccountScreen(),
          '/manage': (context) => const ManageScreen(),
          '/timeline': (context) => const TimelineScreen(),
          '/feed': (context) => const FeedScreen(),
        },
      ),
    );
  }
}
