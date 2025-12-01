import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:honey_bird/core/utils/firebase_options.dart';
import 'core/di/injection.dart' as di;
import 'presentation/theme/app_theme.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/favorites_screen.dart';
import 'presentation/screens/messages_screen.dart';
import 'presentation/screens/account_screen.dart';
import 'presentation/screens/manage_screen.dart';
import 'presentation/screens/timeline_screen.dart';
import 'presentation/screens/feed_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize dependency injection
  await di.init();
  
  runApp(const HoneyBirdApp());
}

/// The root widget of the HoneyBird application
class HoneyBirdApp extends StatelessWidget {
  const HoneyBirdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HoneyBird',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/account': (context) => const AccountScreen(),
        '/manage': (context) => const ManageScreen(),
        '/timeline': (context) => const TimelineScreen(),
        '/feed': (context) => const FeedScreen(),
      },
    );
  }
}
