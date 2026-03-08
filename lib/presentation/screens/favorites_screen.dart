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

/// Favorites screen displaying user's starred (favorited) posts — all from API.
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _currentTabIndex = 1;
  bool _hasRequestedLoad = false;
  bool _hasRequestedUnreadCount = false;

  void _handleTabSelected(int index) {
    if (_currentTabIndex == index) {
      return;
    }

    setState(() {
      _currentTabIndex = index;
    });

    // Navigate to different screens based on tab index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        // Already on Favorites screen
        break;
      case 2:
        Navigator.pushNamed(context, '/account');
        break;
      case 3:
        Navigator.pushNamed(context, '/messages');
        break;
    }
  }

  String? _currentUserUID(BuildContext context) {
    return context.read<AuthBloc>().state.user?.uid;
  }

  void _handleUnstar(BuildContext context, String postId, String userUID) {
    if (userUID.isEmpty) return;
    context.read<FavoritesBloc>().add(FavoritesEvent.unstarPost(
          postId: postId,
          userUID: userUID,
        ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userUID = _currentUserUID(context) ?? '';
    if (!_hasRequestedLoad && userUID.isNotEmpty) {
      _hasRequestedLoad = true;
      context
          .read<FavoritesBloc>()
          .add(FavoritesEvent.loadFavoritePosts(userUID));
    }
    if (!_hasRequestedUnreadCount && userUID.isNotEmpty) {
      _hasRequestedUnreadCount = true;
      context.read<MessagesBloc>().add(MessagesEvent.loadUnreadCount(userUID));
    }
  }

  @override
  void deactivate() {
    _hasRequestedLoad = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final userUID = _currentUserUID(context) ?? '';
    return Container(
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Favorites'),
          elevation: 0,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onBackground),
        ),
        body: SafeArea(
          child: BlocConsumer<FavoritesBloc, FavoritesState>(
            listenWhen: (prev, curr) => curr.errorMessage != prev?.errorMessage,
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            buildWhen: (prev, curr) =>
                prev?.posts != curr.posts ||
                prev?.isLoading != curr.isLoading ||
                prev?.errorMessage != curr.errorMessage,
            builder: (context, state) {
              if (state.isLoading && state.posts.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onBackground),
                  ),
                );
              }

              if (state.errorMessage != null && state.posts.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
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
                          state.errorMessage!,
                          style: bodyLarge.copyWith(
                            color: textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: spacingM),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<FavoritesBloc>()
                                .add(FavoritesEvent.loadFavoritePosts(userUID));
                          },
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

              if (state.posts.isNotEmpty || !state.isLoading) {
                if (state.posts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: textSecondary,
                        ),
                        const SizedBox(height: spacingL),
                        Text(
                          'No favorites yet',
                          style: headlineMedium.copyWith(
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: spacingM),
                        Text(
                          'Posts you favorite will appear here',
                          style: bodyLarge.copyWith(
                            color: textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<FavoritesBloc>()
                        .add(FavoritesEvent.refreshFavoritePosts(userUID));
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  color: accentPink,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      return PostCard(
                        post: post,
                        onLike: () =>
                            _handleUnstar(context, post.id ?? '', userUID),
                        onAuthorTap: (userUID, userName) {
                          Navigator.pushNamed(
                            context,
                            '/profile',
                            arguments: {
                              'userUID': userUID,
                              'userName': userName
                            },
                          );
                        },
                        currentUserUID: userUID.isNotEmpty ? userUID : null,
                      );
                    },
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(textPrimary),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<MessagesBloc, MessagesState>(
          buildWhen: (prev, curr) => prev?.unreadCount != curr.unreadCount,
          builder: (context, messagesState) => BottomNavigationWidget(
            currentIndex: _currentTabIndex,
            onTabSelected: _handleTabSelected,
            unreadMessageCount: messagesState.unreadCount,
          ),
        ),
      ),
    );
  }
}
