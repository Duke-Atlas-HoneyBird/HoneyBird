import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown_widget/markdown_widget.dart';

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
      title: 'HoneyBird',
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
  late final _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: rootBundle.loadString('assets/privacy.md'),
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
          final double screenWidth = MediaQuery.of(context).size.width;
          final double screenHeight = MediaQuery.of(context).size.height;
          return SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                  controller: _scrollController,
                child: MarkdownWidget(
                  data: text,
                  shrinkWrap: true,
                  selectable: true,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
