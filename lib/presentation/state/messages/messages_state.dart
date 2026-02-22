import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/message.dart';

part 'messages_state.freezed.dart';

@freezed
class MessagesState with _$MessagesState {
  const factory MessagesState({
    @Default(false) bool isLoading,
    @Default([]) List<Conversation> conversations,
    @Default(0) int unreadCount,
    @Default([]) List<Message> messages,
    @Default('') String conversationId,
    String? errorMessage,
  }) = _MessagesState;
}
