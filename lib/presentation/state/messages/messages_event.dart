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
}
