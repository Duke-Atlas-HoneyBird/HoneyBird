import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/colours.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/conversation_item.dart';
import '../widgets/message_bubble.dart';
import '../state/messages/messages_bloc.dart';
import '../state/messages/messages_event.dart';
import '../state/messages/messages_state.dart';
import '../../domain/entities/message.dart';
import '../state/auth/auth_bloc.dart';
import '../state/auth/auth_state.dart';

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
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/favorites');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/account');
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
      final userUID = authState is AuthAuthenticated ? authState.user.uid : '';
      context.read<MessagesBloc>().add(LoadConversations(userUID));
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
    String userUID = '';
    if (authState is AuthAuthenticated) {
      userUID = authState.user.uid;
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Text(_selectedConversationId == null ? 'Messages' : 'Conversation'),
            elevation: 0,
            iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onBackground),
            leading: _selectedConversationId != null
                ? IconButton(
                    icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground),
                    onPressed: () {
                      setState(() {
                        _selectedConversationId = null;
                        _selectedConversation = null;
                      });
                    },
                  )
                : null,
          ),
          body: BlocBuilder<MessagesBloc, MessagesState>(
            builder: (context, state) {
              if (_selectedConversationId != null) {
                return _buildConversationView(context, _selectedConversationId!, userUID);
              }

              if (state is MessagesLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onBackground),
                  ),
                );
              }

              if (state is MessagesError) {
                return Center(
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
                        Text(
                          'Error',
                          style: headlineMedium
                        ),
                        const SizedBox(height: spacingS),
                        Text(
                          state.message,
                          style: bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: spacingM),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MessagesBloc>().add(LoadConversations(userUID));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
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

              if (state is ConversationsLoaded) {
                if (state.conversations.isEmpty) {
                  return _NoMessagesYetWidget(
                    onRetry: () => context.read<MessagesBloc>().add(LoadConversations(userUID)),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<MessagesBloc>().add(RefreshConversations(userUID));
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
                          context.read<MessagesBloc>().add(LoadMessages(conversation.id));
                          context.read<MessagesBloc>().add(MarkAsRead(
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
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationWidget(
            currentIndex: _currentTabIndex,
            onTabSelected: _handleTabSelected,
          ),
        ),
    );
  }

  Widget _buildConversationView(BuildContext context, String conversationId, String userUID) {
    final conversation = _selectedConversation;
    return BlocBuilder<MessagesBloc, MessagesState>(
      builder: (context, state) {
        if (state is MessagesLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }

        if (state is MessagesLoaded && state.conversationId == conversationId) {
          String otherUID;
          String otherName;
          if (conversation != null) {
            otherUID = userUID == conversation.participant1UID ? conversation.participant2UID : conversation.participant1UID;
            otherName = userUID == conversation.participant1UID ? conversation.participant2Name : conversation.participant1Name;
          } else {
            final other = _otherParticipantFromMessages(state.messages, userUID);
            otherUID = other.$1;
            otherName = other.$2;
          }
          final senderName = _senderDisplayName(context);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(vertical: spacingM),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[state.messages.length - 1 - index];
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
                receiverUID: otherUID,
                receiverName: otherName,
              ),
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      },
    );
  }

  String _senderDisplayName(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      return authState.user.displayName ?? authState.user.email.split('@').first;
    }
    return 'You';
  }

  (String, String) _otherParticipantFromMessages(List<Message> messages, String userUID) {
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
                  borderRadius: BorderRadius.circular(16),
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
              context.read<MessagesBloc>().add(SendMessage(message, conversationId: widget.conversationId));
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}

/// Empty state when the user has no messages yet.
class _NoMessagesYetWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const _NoMessagesYetWidget({this.onRetry});

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
              size: 80,
              color: Colors.white.withOpacity(0.6),
            ),
            const SizedBox(height: spacingL),
            Text(
              'No messages yet',
              style: headlineMedium.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: spacingM),
            Text(
              'Start a conversation and your messages will appear here.',
              style: bodyLarge.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: spacingL),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, color: Colors.white70),
                label: const Text('Refresh'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white70,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
