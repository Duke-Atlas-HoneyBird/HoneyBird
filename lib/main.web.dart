import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const HoneyBirdWebApp());
}

class HoneyBirdWebApp extends StatelessWidget {
  const HoneyBirdWebApp({super.key});

  static final GoRouter _router = GoRouter(
    initialLocation: '/privacy',
    routes: <GoRoute>[
      GoRoute(
        path: '/privacy',
        builder: (BuildContext context, GoRouterState state) =>
            const _PrivacyScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HoneyBird Privacy',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
    );
  }
}

class _PrivacyScreen extends StatefulWidget {
  const _PrivacyScreen();

  @override
  State<_PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<_PrivacyScreen> {
  late final Future<String> _privacyFuture;

  @override
  void initState() {
    super.initState();
    _privacyFuture = rootBundle.loadString('assets/privacy.md');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: FutureBuilder<String>(
        future: _privacyFuture,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load privacy policy.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          final String text = snapshot.data ?? '';

          return Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SelectableText(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        },
      ),
    );
  }
}