import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/colours.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/post_card.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../bloc/favorites/favorites_state.dart';
import '../bloc/messages/messages_bloc.dart';
import '../bloc/messages/messages_event.dart';
import '../bloc/messages/messages_state.dart';

/// Favorites screen displaying posts starred by the signed-in user only.
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _currentTabIndex = 1;
  String? _lastLoadedUserUID;
  bool _hasRequestedUnreadCount = false;

  void _handleTabSelected(int index) {
    if (_currentTabIndex == index) {
      return;
    }

    setState(() {
      _currentTabIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).popUntil((route) => route.isFirst);
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/account');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/messages');
        break;
    }
  }

  String? _currentUserUID(BuildContext context) {
    return context.read<AuthBloc>().state.user?.uid;
  }

  void _loadFavoritesForUser(String userUID) {
    if (userUID.isEmpty) return;
    context
        .read<FavoritesBloc>()
        .add(FavoritesEvent.loadFavoritePosts(userUID));
  }

  void _handleUnstar(BuildContext context, String postId, String userUID) {
    if (userUID.isEmpty) return;
    context.read<FavoritesBloc>().add(FavoritesEvent.unstarPost(
          postId: postId,
          userUID: userUID,
        ));
  }

  void _onAuthUserChanged(String? userUID) {
    if (userUID == null || userUID.isEmpty) {
      _lastLoadedUserUID = null;
      context.read<FavoritesBloc>().add(const FavoritesEvent.clearFavorites());
      return;
    }

    if (_lastLoadedUserUID == userUID) return;

    _lastLoadedUserUID = userUID;
    _loadFavoritesForUser(userUID);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userUID = _currentUserUID(context) ?? '';
    _onAuthUserChanged(userUID.isEmpty ? null : userUID);

    if (!_hasRequestedUnreadCount && userUID.isNotEmpty) {
      _hasRequestedUnreadCount = true;
      context.read<MessagesBloc>().add(MessagesEvent.loadUnreadCount(userUID));
    }
  }

  @override
  void deactivate() {
    _lastLoadedUserUID = null;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final userUID = _currentUserUID(context) ?? '';
    return Container(
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen: (prev, curr) => prev.user?.uid != curr.user?.uid,
          listener: (context, authState) {
            _onAuthUserChanged(authState.user?.uid);
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: const Text('Favorites'),
              elevation: 0,
              iconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            body: SafeArea(
              child: BlocConsumer<FavoritesBloc, FavoritesState>(
                listenWhen: (prev, curr) =>
                    curr.errorMessage != prev.errorMessage,
                listener: (context, state) {
                  final errorMessage = state.errorMessage;
                  if (errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(errorMessage)),
                    );
                  }
                },
                buildWhen: (prev, curr) =>
                    prev.posts != curr.posts ||
                    prev.isLoading != curr.isLoading ||
                    prev.errorMessage != curr.errorMessage ||
                    prev.userUID != curr.userUID,
                builder: (context, state) {
                  final isSegregated =
                      userUID.isNotEmpty && state.userUID == userUID;
                  final visiblePosts =
                      isSegregated ? state.posts : const [];

                  if (!isSegregated &&
                      (state.isLoading || state.userUID == null)) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    );
                  }

                  if (state.isLoading && visiblePosts.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    );
                  }

                  final errorMessage = state.errorMessage;
                  if (errorMessage != null && visiblePosts.isEmpty) {
                    return _FavoritesErrorWidget(
                      message: errorMessage,
                      onRetry: () => _loadFavoritesForUser(userUID),
                    );
                  }

                  if (visiblePosts.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        _loadFavoritesForUser(userUID);
                        await Future.delayed(
                            const Duration(milliseconds: 500));
                      },
                      color: accentPink,
                      child: _NoFavoritesYetWidget(
                        onRefresh: () => _loadFavoritesForUser(userUID),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<FavoritesBloc>().add(
                          FavoritesEvent.refreshFavoritePosts(userUID));
                      await Future.delayed(const Duration(milliseconds: 500));
                    },
                    color: accentPink,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: visiblePosts.length,
                      itemBuilder: (context, index) {
                        final post = visiblePosts[index];
                        return PostCard(
                          post: post,
                          onLike: () =>
                              _handleUnstar(context, post.id, userUID),
                          onAuthorTap: (authorUID, userName) {
                            Navigator.pushNamed(
                              context,
                              '/profile',
                              arguments: {
                                'userUID': authorUID,
                                'userName': userName,
                              },
                            );
                          },
                          currentUserUID:
                              userUID.isNotEmpty ? userUID : null,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: BlocBuilder<MessagesBloc, MessagesState>(
              buildWhen: (prev, curr) =>
                  prev.unreadCount != curr.unreadCount,
              builder: (context, messagesState) => BottomNavigationWidget(
                currentIndex: _currentTabIndex,
                onTabSelected: _handleTabSelected,
                unreadMessageCount: messagesState.unreadCount,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FavoritesErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _FavoritesErrorWidget({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(spacingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: textPrimary,
            ),
            const SizedBox(height: spacingM),
            Text(
              'Error',
              style: headlineMedium.copyWith(
                color: textPrimary,
              ),
            ),
            const SizedBox(height: spacingS),
            Text(
              message,
              style: bodyLarge.copyWith(
                color: textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: spacingM),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: accentPink,
                foregroundColor: surfaceColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: spacingL,
                  vertical: spacingM,
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty state when the signed-in user has no favourited posts.
class _NoFavoritesYetWidget extends StatelessWidget {
  final VoidCallback? onRefresh;

  const _NoFavoritesYetWidget({this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: spacingL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: textSecondary,
                    ),
                    const SizedBox(height: spacingL),
                    Text(
                      'No favorites yet',
                      style: headlineMedium.copyWith(
                        color: textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spacingM),
                    Text(
                      'Star posts from the feed and they will appear here.',
                      style: bodyLarge.copyWith(
                        color: textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (onRefresh != null) ...[
                      const SizedBox(height: spacingL),
                      TextButton.icon(
                        onPressed: onRefresh,
                        icon: Icon(Icons.refresh, color: textSecondary),
                        label: const Text('Refresh'),
                        style: TextButton.styleFrom(
                          foregroundColor: textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
