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
import '../widgets/merchant_channel_banner.dart';
import '../widgets/restaurant_picker_sheet.dart';
import '../bloc/messages/messages_bloc.dart';
import '../bloc/messages/messages_event.dart';
import '../bloc/messages/messages_state.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/restaurant.dart';
import '../bloc/auth/auth_bloc.dart';

/// Global key for [MessagesScreen] to allow resetting its state (e.g. from app bar leading).
final messagesScreenGlobalKey = GlobalKey<_MessagesScreenState>();

/// Messages screen for mediated B2C restaurant inquiries.
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
    if (_currentTabIndex == index) return;

    setState(() {
      _currentTabIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).popUntil((route) => route.isFirst);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/favorites');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/account');
        break;
      case 3:
        break;
    }
  }

  void _openRestaurantPicker() {
    final bloc = context.read<MessagesBloc>();
    bloc.add(const MessagesEvent.loadRestaurants());
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => BlocProvider.value(
        value: bloc,
        child: BlocBuilder<MessagesBloc, MessagesState>(
          builder: (context, state) => RestaurantPickerSheet(
            restaurants: state.restaurants,
            isLoading: state.isLoadingRestaurants,
            onRestaurantSelected: _startRestaurantConversation,
          ),
        ),
      ),
    );
  }

  void _startRestaurantConversation(Restaurant restaurant) {
    HapticFeedback.lightImpact();
    final authState = context.read<AuthBloc>().state;
    final user = authState.user;
    if (user == null) return;

    final userName = user.displayName ?? user.email.split('@').first;

    context.read<MessagesBloc>().add(
          MessagesEvent.openConversationWithRestaurant(
            userUID: user.uid,
            userName: userName,
            restaurantId: restaurant.id,
            restaurantName: restaurant.name,
          ),
        );

    setState(() {
      _selectedConversationId =
          Conversation.idFor(user.uid, restaurant.id);
      _selectedConversation = null;
    });
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

  String _conversationTitle(MessagesState state) {
    if (state.conversationId.isEmpty && _selectedConversation == null) {
      return 'Restaurant Inquiries';
    }
    return state.openWithRestaurantName ??
        _selectedConversation?.restaurantName ??
        'Merchant';
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final userUID = authState.user?.uid ?? '';

    return Container(
      decoration: const BoxDecoration(gradient: backgroundGradient),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (_selectedConversationId != null) {
            reset();
          } else {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<MessagesBloc, MessagesState>(
              buildWhen: (prev, curr) =>
                  prev.conversationId != curr.conversationId ||
                  prev.openWithRestaurantName != curr.openWithRestaurantName,
              builder: (context, s) => Text(_conversationTitle(s)),
            ),
            centerTitle: false,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            leading: BlocBuilder<MessagesBloc, MessagesState>(
              buildWhen: (prev, curr) =>
                  prev.conversationId != curr.conversationId,
              builder: (context, s) {
                if (s.conversationId.isEmpty &&
                    _selectedConversationId == null) {
                  return IconButton(
                    icon: Icon(Icons.arrow_back_ios_rounded,
                        color: Theme.of(context).colorScheme.onSurface),
                    onPressed: () => _handleTabSelected(0),
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
            actions: [
              if (_selectedConversationId == null)
                IconButton(
                  icon: const Icon(Icons.add_comment_outlined),
                  tooltip: 'Contact a restaurant',
                  onPressed: _openRestaurantPicker,
                ),
            ],
          ),
          body: SafeArea(
            child: BlocConsumer<MessagesBloc, MessagesState>(
              listenWhen: (prev, curr) =>
                  curr.errorMessage != prev.errorMessage ||
                  curr.restaurants != prev.restaurants ||
                  curr.isLoadingRestaurants != prev.isLoadingRestaurants,
              listener: (context, state) {
                final errorMessage = state.errorMessage;
                if (errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
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
                    restaurantId: state.openWithRestaurantId,
                    restaurantName: state.openWithRestaurantName,
                  );
                }

                if (state.isLoading && state.conversations.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  );
                }

                final errorMessage = state.errorMessage;
                if (errorMessage != null && state.conversations.isEmpty) {
                  return _ErrorState(
                    message: errorMessage,
                    onRetry: () => context.read<MessagesBloc>().add(
                          MessagesEvent.loadConversations(userUID),
                        ),
                  );
                }

                if (state.conversations.isEmpty) {
                  return _NoInquiriesYetWidget(
                    onContactRestaurant: _openRestaurantPicker,
                    onRetry: () => context.read<MessagesBloc>().add(
                          MessagesEvent.loadConversations(userUID),
                        ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<MessagesBloc>().add(
                          MessagesEvent.refreshConversations(userUID),
                        );
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
                          context.read<MessagesBloc>().add(
                                MessagesEvent.loadMessages(conversation.id),
                              );
                          context.read<MessagesBloc>().add(
                                MessagesEvent.markAsRead(
                                  conversationId: conversation.id,
                                  userUID: userUID,
                                ),
                              );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: _selectedConversationId == null
              ? BlocBuilder<MessagesBloc, MessagesState>(
                  buildWhen: (prev, curr) =>
                      prev.unreadCount != curr.unreadCount,
                  builder: (context, messagesState) => BottomNavigationWidget(
                    currentIndex: _currentTabIndex,
                    onTabSelected: _handleTabSelected,
                    unreadMessageCount: messagesState.unreadCount,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildConversationView(
    BuildContext context,
    String conversationId,
    String userUID, {
    String? restaurantId,
    String? restaurantName,
  }) {
    final conversation = _selectedConversation;
    final resolvedRestaurantId = restaurantId ?? conversation?.restaurantId ?? '';
    final resolvedRestaurantName =
        restaurantName ?? conversation?.restaurantName ?? 'Restaurant';

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
          final senderName = _senderDisplayName(context);

          return Column(
            children: [
              MerchantChannelBanner(restaurantName: resolvedRestaurantName),
              Expanded(
                child: state.messages.isEmpty
                    ? _TypeFirstInquiryWidget(
                        restaurantName: resolvedRestaurantName,
                      )
                    : ListView.builder(
                        reverse: true,
                        padding:
                            const EdgeInsets.symmetric(vertical: spacingM),
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message = state
                              .messages[state.messages.length - 1 - index];
                          final isCurrentUser =
                              message.senderType == MessageSenderType.user &&
                                  message.senderUID == userUID;
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
                restaurantId: resolvedRestaurantId,
                restaurantName: resolvedRestaurantName,
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
}

class _MessageInputBar extends StatefulWidget {
  final String conversationId;
  final String userUID;
  final String senderName;
  final String restaurantId;
  final String restaurantName;

  const _MessageInputBar({
    required this.conversationId,
    required this.userUID,
    required this.senderName,
    required this.restaurantId,
    required this.restaurantName,
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
                hintText: 'Ask about your order or reservation…',
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
                senderType: MessageSenderType.user,
                senderUID: widget.userUID,
                senderName: widget.senderName,
                receiverUID: widget.restaurantId,
                receiverName: widget.restaurantName,
                content: text,
                timestamp: DateTime.now(),
              );
              context.read<MessagesBloc>().add(MessagesEvent.sendMessage(
                    message,
                    conversationId: widget.conversationId,
                  ));
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}

class _NoInquiriesYetWidget extends StatelessWidget {
  final VoidCallback onContactRestaurant;
  final VoidCallback? onRetry;

  const _NoInquiriesYetWidget({
    required this.onContactRestaurant,
    this.onRetry,
  });

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
                      Icons.storefront_outlined,
                      size: 80,
                      color: textSecondary,
                    ),
                    const SizedBox(height: spacingL),
                    Text(
                      'No restaurant inquiries yet',
                      style: headlineMedium.copyWith(color: textPrimary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spacingM),
                    Text(
                      'Contact a restaurant for order-related questions. '
                      'Messages are routed through Honey Bird to the merchant — '
                      'you are never chatting directly with other users.',
                      style: bodyLarge.copyWith(color: textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: spacingL),
                    FilledButton.icon(
                      onPressed: onContactRestaurant,
                      icon: const Icon(Icons.add_comment_outlined),
                      label: const Text('Contact a restaurant'),
                      style: FilledButton.styleFrom(
                        backgroundColor: accentPink,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: spacingL,
                          vertical: spacingM,
                        ),
                      ),
                    ),
                    if (onRetry != null) ...[
                      const SizedBox(height: spacingM),
                      TextButton.icon(
                        onPressed: onRetry,
                        icon: const Icon(Icons.refresh, color: textSecondary),
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

class _TypeFirstInquiryWidget extends StatelessWidget {
  final String restaurantName;

  const _TypeFirstInquiryWidget({required this.restaurantName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spacingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.receipt_long_outlined, size: 64, color: textSecondary),
            const SizedBox(height: spacingL),
            Text(
              'Send your first inquiry',
              style: headlineMedium.copyWith(color: textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: spacingM),
            Text(
              'Ask $restaurantName about orders, reservations, or menu items below.',
              style: bodyLarge.copyWith(color: textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(spacingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: spacingM),
              Text('Error', style: headlineMedium),
              const SizedBox(height: spacingS),
              Text(
                message,
                style: bodyLarge,
                textAlign: TextAlign.center,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: spacingM),
              ElevatedButton(
                onPressed: onRetry,
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
}

/// Opens a B2C conversation with a restaurant and navigates to messages.
void openRestaurantConversation(
  BuildContext context, {
  required String restaurantId,
  required String restaurantName,
}) {
  final authState = context.read<AuthBloc>().state;
  final user = authState.user;
  if (user == null) return;

  final userName = user.displayName ?? user.email.split('@').first;

  context.read<MessagesBloc>().add(
        MessagesEvent.openConversationWithRestaurant(
          userUID: user.uid,
          userName: userName,
          restaurantId: restaurantId,
          restaurantName: restaurantName,
        ),
      );

  Navigator.pushNamed(context, '/messages');
}
