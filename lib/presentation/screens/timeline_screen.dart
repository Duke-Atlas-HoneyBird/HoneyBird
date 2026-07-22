import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honey_bird/presentation/bloc/auth/auth_bloc.dart';
import 'package:honey_bird/presentation/bloc/auth/auth_state.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../bloc/timeline/timeline_bloc.dart';
import '../bloc/timeline/timeline_event.dart';
import '../bloc/timeline/timeline_state.dart';
import '../bloc/messages/messages_bloc.dart';
import '../bloc/messages/messages_state.dart';
import '../widgets/post_card.dart';

/// Timeline screen displaying chronological content
class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentTabIndex = 0;
  bool _hasRequestedLoad = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasRequestedLoad) {
      _hasRequestedLoad = true;
      final uid = context.read<AuthBloc>().state.user?.uid;
      context.read<TimelineBloc>().add(TimelineEvent.loadTimelinePosts(userUID: uid));
    }
  }

  @override
  void deactivate() {
    _hasRequestedLoad = false;
    super.deactivate();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && mounted) {
      final uid = context.read<AuthBloc>().state.user?.uid;
      context.read<TimelineBloc>().add(TimelineEvent.loadMoreTimelinePosts(userUID: uid));
    }
  }

  void _handleTabSelected(int index) {
    if (_currentTabIndex == index) {
      return;
    }

    setState(() {
      _currentTabIndex = index;
    });

    AppRoutes.goTab(context, index);
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          context.go(AppRoutes.home);
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text('Timeline'),
            elevation: 0,
            iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onBackground),
          ),
          body: SafeArea(
            child: BlocConsumer<TimelineBloc, TimelineState>(
            listenWhen: (prev, curr) => curr.errorMessage != prev.errorMessage,
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            buildWhen: (prev, curr) =>
                prev.posts != curr.posts ||
                prev.isLoading != curr.isLoading ||
                prev.errorMessage != curr.errorMessage,
            builder: (context, state) {
              if (state.isLoading && state.posts.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onBackground),
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
                            context.read<TimelineBloc>().add(TimelineEvent.loadTimelinePosts(userUID: context.read<AuthBloc>().state.user?.uid));
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
                          Icons.timeline_outlined,
                          size: 64,
                          color: textSecondary,
                        ),
                        const SizedBox(height: spacingL),
                        Text(
                          'No posts yet',
                          style: headlineMedium.copyWith(
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: spacingM),
                        Text(
                          'Your timeline will appear here',
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
                    context.read<TimelineBloc>().add(TimelineEvent.refreshTimelinePosts(userUID: context.read<AuthBloc>().state.user?.uid));
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  color: accentPink,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.posts.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.posts.length) {
                        return const Padding(
                          padding: EdgeInsets.all(spacingM),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final post = state.posts[index];
                      final currentUserUID = context.read<AuthBloc>().state.user?.uid;
                      return PostCard(
                        post: post,
                        onLike: () => _handleLike(
                          context,
                          post.id ?? '',
                          currentUserUID,
                        ),
                        onAuthorTap: (userUID, userName) {
                          context.push(AppRoutes.profileLocation(userUID, userName));
                        },
                        currentUserUID: currentUserUID,
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
            buildWhen: (prev, curr) => prev.unreadCount != curr.unreadCount,
            builder: (context, messagesState) => BottomNavigationWidget(
              currentIndex: _currentTabIndex,
              onTabSelected: _handleTabSelected,
              unreadMessageCount: messagesState.unreadCount,
            ),
          ),
        ),
        ),
    );
  }

  void _handleLike(
    BuildContext context,
    String postId,
    String? currentUserUID,
  ) {
    if (currentUserUID == null) return;
    context.read<TimelineBloc>().add(TimelineEvent.likePostInTimeline(
          postId: postId,
          userUID: currentUserUID,
        ));
  }
}
