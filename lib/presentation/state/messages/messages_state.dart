import 'package:equatable/equatable.dart';
import '../../../domain/entities/message.dart';

/// Base class for Messages states
abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class MessagesInitial extends MessagesState {
  const MessagesInitial();
}

/// Loading state
class MessagesLoading extends MessagesState {
  const MessagesLoading();
}

/// Loaded conversations state
class ConversationsLoaded extends MessagesState {
  final List<Conversation> conversations;
  final int unreadCount;

  const ConversationsLoaded({
    required this.conversations,
    this.unreadCount = 0,
  });

  @override
  List<Object?> get props => [conversations, unreadCount];
}

/// Loaded messages state (for a specific conversation)
class MessagesLoaded extends MessagesState {
  final List<Message> messages;
  final String conversationId;

  const MessagesLoaded({
    required this.messages,
    required this.conversationId,
  });

  @override
  List<Object?> get props => [messages, conversationId];
}

/// Error state
class MessagesError extends MessagesState {
  final String message;

  const MessagesError(this.message);

  @override
  List<Object?> get props => [message];
}

