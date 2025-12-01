import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/conversation_item.dart';
import '../widgets/message_bubble.dart';
import '../state/messages/messages_bloc.dart';
import '../state/messages/messages_event.dart';
import '../state/messages/messages_state.dart';
import '../../domain/entities/message.dart';
import '../../infrastructure/repositories/message_repository_impl.dart';

/// Messages screen displaying user conversations
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _currentTabIndex = 3; // Messages is index 3
  String? _selectedConversationId;
  String _currentUserUID = 'current_user'; // Dummy user ID

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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagesBloc(
        messageRepository: MessageRepositoryImpl(),
      )..add(LoadConversations(_currentUserUID)),
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              _selectedConversationId == null ? 'Messages' : 'Conversation',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            leading: _selectedConversationId != null
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        _selectedConversationId = null;
                      });
                    },
                  )
                : null,
          ),
          body: BlocBuilder<MessagesBloc, MessagesState>(
            builder: (context, state) {
              if (_selectedConversationId != null) {
                return _buildConversationView(context, _selectedConversationId!);
              }

              if (state is MessagesLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              }

              if (state is MessagesError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.white,
                        ),
                        const SizedBox(height: AppTheme.spacingM),
                        Text(
                          'Error',
                          style: AppTheme.headlineMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingS),
                        Text(
                          state.message,
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppTheme.spacingM),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MessagesBloc>().add(LoadConversations(_currentUserUID));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentPink,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingL,
                              vertical: AppTheme.spacingM,
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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.message_outlined,
                          size: 64,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                        const SizedBox(height: AppTheme.spacingL),
                        Text(
                          'No conversations yet',
                          style: AppTheme.headlineMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingM),
                        Text(
                          'Your messages will appear here',
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<MessagesBloc>().add(RefreshConversations(_currentUserUID));
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  color: AppTheme.accentPink,
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
                          });
                          context.read<MessagesBloc>().add(LoadMessages(conversation.id ?? ''));
                          context.read<MessagesBloc>().add(MarkAsRead(
                                conversationId: conversation.id ?? '',
                                userUID: _currentUserUID,
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
      ),
    );
  }

  Widget _buildConversationView(BuildContext context, String conversationId) {
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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[state.messages.length - 1 - index];
                    final isCurrentUser = message.senderUID == _currentUserUID;
                    return MessageBubble(
                      message: message,
                      isCurrentUser: isCurrentUser,
                    );
                  },
                ),
              ),
              _buildMessageInput(context, conversationId),
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

  Widget _buildMessageInput(BuildContext context, String conversationId) {
    final controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM,
                  vertical: AppTheme.spacingS,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacingS),
          IconButton(
            icon: const Icon(Icons.send),
            color: AppTheme.accentPink,
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                HapticFeedback.lightImpact();
                final message = Message(
                  senderUID: _currentUserUID,
                  senderName: 'You',
                  receiverUID: 'other_user',
                  receiverName: 'Other User',
                  content: controller.text.trim(),
                  timestamp: DateTime.now(),
                );
                context.read<MessagesBloc>().add(SendMessage(message));
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
