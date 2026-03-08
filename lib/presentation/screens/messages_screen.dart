import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/border_radius.dart';
import '../theme/colours.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/conversation_item.dart';
import '../widgets/message_bubble.dart';
import '../bloc/messages/messages_bloc.dart';
import '../bloc/messages/messages_event.dart';
import '../bloc/messages/messages_state.dart';
import '../../domain/entities/message.dart';
import '../bloc/auth/auth_bloc.dart';

/// Global key for [MessagesScreen] to allow resetting its state (e.g. from app bar leading).
final messagesScreenGlobalKey = GlobalKey<_MessagesScreenState>();

/// Messages screen displaying user conversations
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _currentTabIndex = 3;
  String? _selectedConversationId;
  Conversation? _selectedConversation;
  bool _hasRequestedLoad = false;

  /// Resets the screen state (e.g. when navigating back from a conversation).
  void reset() {
    setState(() {
      _selectedConversationId = null;
      _selectedConversation = null;
    });
    context
        .read<MessagesBloc>()
        .add(const MessagesEvent.clearOpenConversation());
  }

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
        Navigator.popAndPushNamed(context, '/home');
        break;
      case 1:
        Navigator.popAndPushNamed(context, '/favorites');
        break;
      case 2:
        Navigator.popAndPushNamed(context, '/account');
        break;
      case 3:
        // Already on Messages screen
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasRequestedLoad) {
      _hasRequestedLoad = true;
      final authState = context.read<AuthBloc>().state;
      final userUID = authState.user?.uid ?? '';
      context
          .read<MessagesBloc>()
          .add(MessagesEvent.loadConversations(userUID));
    }
  }

  @override
  void deactivate() {
    _hasRequestedLoad = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final userUID = authState.user?.uid ?? '';
    final participantName = _selectedConversation?.participant1Name;
    return Container(
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<MessagesBloc, MessagesState>(
            buildWhen: (prev, curr) =>
                prev.conversationId != curr.conversationId ||
                prev.openWithUserName != curr.openWithUserName,
            builder: (context, s) => Text(
              s.conversationId.isEmpty && _selectedConversation == null
                  ? 'Messages'
                  : (s.openWithUserName ??
                      _selectedConversation?.participant1Name ??
                      participantName ??
                      'Conversation'),
            ),
          ),
          centerTitle: false,
          elevation: 0,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onBackground),
          leading: BlocBuilder<MessagesBloc, MessagesState>(
            buildWhen: (prev, curr) =>
                prev.conversationId != curr.conversationId,
            builder: (context, s) {
              if (s.conversationId.isEmpty && _selectedConversationId == null) {
                return IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded,
                      color: Theme.of(context).colorScheme.onSurface),
                  onPressed: () {
                    int homePageIndex = 0;
                    _handleTabSelected(homePageIndex);
                  },
                );
              }
              return IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded,
                    color: Theme.of(context).colorScheme.onSurface),
                onPressed: () {
                  messagesScreenGlobalKey.currentState?.reset();
                },
              );
            },
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<MessagesBloc, MessagesState>(
            listenWhen: (prev, curr) => curr.errorMessage != prev.errorMessage,
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            buildWhen: (prev, curr) =>
                prev.conversations != curr.conversations ||
                prev.messages != curr.messages ||
                prev.conversationId != curr.conversationId ||
                prev.isLoading != curr.isLoading ||
                prev.errorMessage != curr.errorMessage,
            builder: (context, state) {
              final activeConvId = _selectedConversationId ??
                  (state.conversationId.isNotEmpty
                      ? state.conversationId
                      : null);
              if (activeConvId != null) {
                return _buildConversationView(
                  context,
                  activeConvId,
                  userUID,
                  otherUID: state.openWithUserUID,
                  otherName: state.openWithUserName,
                );
              }

              if (state.isLoading && state.conversations.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onBackground),
                  ),
                );
              }

              if (state.errorMessage != null && state.conversations.isEmpty) {
                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(spacingL),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                          ),
                          const SizedBox(height: spacingM),
                          Text('Error', style: headlineMedium),
                          const SizedBox(height: spacingS),
                          Text(
                            state.errorMessage!,
                            style: bodyLarge,
                            textAlign: TextAlign.center,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: spacingM),
                          ElevatedButton(
                            onPressed: () {
                              context.read<MessagesBloc>().add(
                                  MessagesEvent.loadConversations(userUID));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
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
                  ),
                );
              }

              if (state.conversations.isNotEmpty || !state.isLoading) {
                if (state.conversations.isEmpty) {
                  return _NoMessagesYetWidget(
                    onRetry: () => context
                        .read<MessagesBloc>()
                        .add(MessagesEvent.loadConversations(userUID)),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<MessagesBloc>()
                        .add(MessagesEvent.refreshConversations(userUID));
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  color: accentPink,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = state.conversations[index];
                      return ConversationItem(
                        conversation: conversation,
                        onTap: () {
                          setState(() {
                            _selectedConversationId = conversation.id;
                            _selectedConversation = conversation;
                          });
                          context
                              .read<MessagesBloc>()
                              .add(MessagesEvent.loadMessages(conversation.id));
                          context
                              .read<MessagesBloc>()
                              .add(MessagesEvent.markAsRead(
                                conversationId: conversation.id,
                                userUID: userUID,
                              ));
                        },
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
        bottomNavigationBar: _selectedConversationId == null
            ? BlocBuilder<MessagesBloc, MessagesState>(
                buildWhen: (prev, curr) => prev.unreadCount != curr.unreadCount,
                builder: (context, messagesState) => BottomNavigationWidget(
                  currentIndex: _currentTabIndex,
                  onTabSelected: _handleTabSelected,
                  unreadMessageCount: messagesState.unreadCount,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildConversationView(
    BuildContext context,
    String conversationId,
    String userUID, {
    String? otherUID,
    String? otherName,
  }) {
    final conversation = _selectedConversation;
    return BlocBuilder<MessagesBloc, MessagesState>(
      buildWhen: (prev, curr) =>
          prev.messages != curr.messages ||
          prev.conversationId != curr.conversationId ||
          prev.isLoading != curr.isLoading,
      builder: (context, state) {
        if (state.isLoading && state.messages.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(textPrimary),
            ),
          );
        }

        if (state.conversationId == conversationId) {
          String resolvedOtherUID;
          String resolvedOtherName;
          if (otherUID != null && otherName != null) {
            resolvedOtherUID = otherUID;
            resolvedOtherName = otherName;
          } else if (conversation != null) {
            resolvedOtherUID = userUID == conversation.participant1UID
                ? conversation.participant2UID
                : conversation.participant1UID;
            resolvedOtherName = userUID == conversation.participant1UID
                ? conversation.participant2Name
                : conversation.participant1Name;
          } else {
            final other =
                _otherParticipantFromMessages(state.messages, userUID);
            resolvedOtherUID = other.$1;
            resolvedOtherName = other.$2;
          }
          final senderName = _senderDisplayName(context);

          return Column(
            children: [
              Expanded(
                child: state.messages.isEmpty
                    ? const _TypeFirstMessageWidget()
                    : ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(vertical: spacingM),
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message =
                              state.messages[state.messages.length - 1 - index];
                          final isCurrentUser = message.senderUID == userUID;
                          return MessageBubble(
                            message: message,
                            isCurrentUser: isCurrentUser,
                          );
                        },
                      ),
              ),
              _MessageInputBar(
                conversationId: conversationId,
                userUID: userUID,
                senderName: senderName,
                receiverUID: resolvedOtherUID,
                receiverName: resolvedOtherName,
              ),
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(textPrimary),
          ),
        );
      },
    );
  }

  String _senderDisplayName(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;
    if (user != null) {
      return user.displayName ?? user.email.split('@').first;
    }
    return 'You';
  }

  (String, String) _otherParticipantFromMessages(
      List<Message> messages, String userUID) {
    for (final m in messages) {
      if (m.senderUID != userUID) return (m.senderUID, m.senderName);
      if (m.receiverUID != userUID) return (m.receiverUID, m.receiverName);
    }
    return ('', 'User');
  }
}

/// Message input bar with its own controller so it is not recreated on every build.
class _MessageInputBar extends StatefulWidget {
  final String conversationId;
  final String userUID;
  final String senderName;
  final String receiverUID;
  final String receiverName;

  const _MessageInputBar({
    required this.conversationId,
    required this.userUID,
    required this.senderName,
    required this.receiverUID,
    required this.receiverName,
  });

  @override
  State<_MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<_MessageInputBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spacingM),
      decoration: BoxDecoration(
        color: cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: spacingM,
                  vertical: spacingS,
                ),
              ),
            ),
          ),
          const SizedBox(width: spacingS),
          IconButton(
            icon: const Icon(Icons.send),
            color: accentPink,
            onPressed: () {
              final text = _controller.text.trim();
              if (text.isEmpty) return;
              HapticFeedback.lightImpact();
              final message = Message(
                senderUID: widget.userUID,
                senderName: widget.senderName,
                receiverUID: widget.receiverUID,
                receiverName: widget.receiverName,
                content: text,
                timestamp: DateTime.now(),
              );
              context.read<MessagesBloc>().add(MessagesEvent.sendMessage(
                  message,
                  conversationId: widget.conversationId));
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}

/// Empty state when the user has no conversations yet.
class _NoMessagesYetWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const _NoMessagesYetWidget({this.onRetry});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: spacingL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 80,
                      color: textSecondary,
                    ),
                    const SizedBox(height: spacingL),
                    Text(
                      'No messages yet',
                      style: headlineMedium.copyWith(
                        color: textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spacingM),
                    Text(
                      'Visit someone\'s profile from the feed and tap Message to start a conversation.',
                      style: bodyLarge.copyWith(
                        color: textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (onRetry != null) ...[
                      const SizedBox(height: spacingL),
                      TextButton.icon(
                        onPressed: onRetry,
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

/// Empty state when a conversation has no messages yet.
class _TypeFirstMessageWidget extends StatelessWidget {
  const _TypeFirstMessageWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spacingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 64,
              color: textSecondary,
            ),
            const SizedBox(height: spacingL),
            Text(
              'Type your first message',
              style: headlineMedium.copyWith(
                color: textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: spacingM),
            Text(
              'Say hello and start the conversation below.',
              style: bodyLarge.copyWith(
                color: textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
