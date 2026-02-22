import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/message.dart';

part 'messages_event.freezed.dart';

@freezed
class MessagesEvent with _$MessagesEvent {
  const factory MessagesEvent.loadConversations(String userUID) =
      LoadConversations;
  const factory MessagesEvent.loadMessages(String conversationId) =
      LoadMessages;
  const factory MessagesEvent.sendMessage(
    Message message, {
    String? conversationId,
  }) = SendMessage;
  const factory MessagesEvent.markAsRead({
    required String conversationId,
    required String userUID,
  }) = MarkAsRead;
  const factory MessagesEvent.refreshConversations(String userUID) =
      RefreshConversations;
  const factory MessagesEvent.loadUnreadCount(String userUID) = LoadUnreadCount;
  const factory MessagesEvent.openConversationWith({
    required String currentUserUID,
    required String currentUserName,
    required String otherUserUID,
    required String otherUserName,
  }) = OpenConversationWith;
  const factory MessagesEvent.clearOpenConversation() = ClearOpenConversation;
}
