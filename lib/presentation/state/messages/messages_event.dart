import 'package:equatable/equatable.dart';
import '../../../domain/entities/message.dart';

/// Base class for Messages events
abstract class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load conversations
class LoadConversations extends MessagesEvent {
  final String userUID;

  const LoadConversations(this.userUID);

  @override
  List<Object?> get props => [userUID];
}

/// Event to load messages for a conversation
class LoadMessages extends MessagesEvent {
  final String conversationId;

  const LoadMessages(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

/// Event to send a message
class SendMessage extends MessagesEvent {
  final Message message;

  const SendMessage(this.message);

  @override
  List<Object?> get props => [message];
}

/// Event to mark conversation as read
class MarkAsRead extends MessagesEvent {
  final String conversationId;
  final String userUID;

  const MarkAsRead({
    required this.conversationId,
    required this.userUID,
  });

  @override
  List<Object?> get props => [conversationId, userUID];
}

/// Event to refresh conversations
class RefreshConversations extends MessagesEvent {
  final String userUID;

  const RefreshConversations(this.userUID);

  @override
  List<Object?> get props => [userUID];
}

