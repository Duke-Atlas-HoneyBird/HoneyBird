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
      GoRoute(
        path: '/delete',
        builder: (BuildContext context, GoRouterState state) =>
            const _DeleteScreen(),
      ),
      GoRoute(
        path: '/terms',
        builder: (BuildContext context, GoRouterState state) =>
            const _TermsScreen(),
      ),
      GoRoute(
        path: '/community-guidelines',
        builder: (BuildContext context, GoRouterState state) =>
            const _CommunityGuidelinesBody(),
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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 251, 230, 255)),
        useMaterial3: true,
      ),
    );
  }
}

class _TermsScreen extends StatelessWidget {
  const _TermsScreen();

  @override
  Widget build(BuildContext context) {
    return _MarkdownPageBody(
      future: rootBundle.loadString('assets/docs/terms.md'),
    );
  }
}

class _CommunityGuidelinesBody extends StatelessWidget {
  const _CommunityGuidelinesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return _MarkdownPageBody(
      future: rootBundle.loadString('assets/docs/community_guidelines.md'),
    );
  }
}

class _DeleteScreen extends StatelessWidget {
  const _DeleteScreen();

  @override
  Widget build(BuildContext context) {
    return _MarkdownPageBody(
      future: rootBundle.loadString('assets/docs/delete.md'),
    );
  }
}

class _PrivacyScreen extends StatelessWidget {
  const _PrivacyScreen();

  @override
  Widget build(BuildContext context) {
    return _MarkdownPageBody(
      future: rootBundle.loadString('assets/docs/privacy.md'),
    );
  }
}

class _MarkdownPageBody extends StatefulWidget {
  const _MarkdownPageBody({super.key, required this.future});

  final Future<String> future;

  @override
  State<_MarkdownPageBody> createState() => _MarkdownPageBodyState();
}

class _MarkdownPageBodyState extends State<_MarkdownPageBody> {
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
        future: widget.future,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load this page.',
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
