import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/message_repository.dart';
import 'messages_event.dart';
import 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessageRepository messageRepository;

  MessagesBloc({required this.messageRepository})
      : super(const MessagesState()) {
    on<LoadConversations>(_onLoadConversations);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<MarkAsRead>(_onMarkAsRead);
    on<RefreshConversations>(_onRefreshConversations);
  }

  Future<void> _onLoadConversations(
    LoadConversations event,
    Emitter<MessagesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await messageRepository.getConversations(event.userUID);

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load conversations',
          conversations: [])),
      (conversations) => emit(state.copyWith(
          isLoading: false,
          conversations: conversations,
          unreadCount: conversations.fold(
              0, (sum, chat) => sum + chat.unreadCount))),
    );
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<MessagesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await messageRepository.getMessages(event.conversationId);

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load messages: ${failure.message}',
          messages: [])),
      (messages) => emit(state.copyWith(
          isLoading: false,
          messages: messages,
          conversationId: event.conversationId)),
    );
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<MessagesState> emit,
  ) async {
    final result = await messageRepository.sendMessage(event.message,
        conversationId: event.conversationId);

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: 'Failed to send message: ${failure.message}')),
      (sentMessage) => emit(state.copyWith(
          messages: [...state.messages, sentMessage],
          conversationId: state.conversationId)),
    );
  }

  Future<void> _onMarkAsRead(
    MarkAsRead event,
    Emitter<MessagesState> emit,
  ) async {
    await messageRepository.markAsRead(
        event.conversationId, event.userUID);
    if (state.conversations.isNotEmpty) {
      add(MessagesEvent.refreshConversations(event.userUID));
    }
  }

  Future<void> _onRefreshConversations(
    RefreshConversations event,
    Emitter<MessagesState> emit,
  ) async {
    final result = await messageRepository.getConversations(event.userUID);

    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: 'Failed to refresh: ${failure.message}')),
      (conversations) async {
        final unreadResult =
            await messageRepository.getUnreadCount(event.userUID);
        final unreadCount =
            unreadResult.fold((failure) => 0, (count) => count);
        emit(state.copyWith(
            conversations: conversations, unreadCount: unreadCount));
      },
    );
  }
}
