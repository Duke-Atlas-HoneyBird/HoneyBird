import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/message_repository.dart';
import 'messages_event.dart';
import 'messages_state.dart';

/// Bloc for managing messages state and business logic
class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessageRepository messageRepository;

  MessagesBloc({required this.messageRepository}) : super(const MessagesInitial()) {
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
    emit(const MessagesLoading());
    
    final result = await messageRepository.getConversations(event.userUID);
    
    result.fold(
      (failure) => emit(const MessagesError('Failed to load conversations')),
      (conversations) async {
        // final unreadResult = await messageRepository.getUnreadCount(event.userUID);
        // final unreadCount = unreadResult.fold(
        //   (failure) => 0,
        //   (count) => count,
        // );
        emit(ConversationsLoaded(
          conversations: conversations,
          unreadCount: conversations.fold(0, (sum, chat) => sum + chat.unreadCount),
        ));
      },
    );
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<MessagesState> emit,
  ) async {
    emit(const MessagesLoading());
    
    final result = await messageRepository.getMessages(event.conversationId);
    
    result.fold(
      (failure) => emit( MessagesError('Failed to load messages: ${failure.message}')),
      (messages) => emit(MessagesLoaded(
        messages: messages,
        conversationId: event.conversationId,
      )),
    );
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<MessagesState> emit,
  ) async {
    final result = await messageRepository.sendMessage(event.message, conversationId: event.conversationId);
    
    result.fold(
      (failure) => emit(MessagesError('Failed to send message: ${failure.message}')),
      (sentMessage) {
        // Reload messages for the conversation
        if (state is MessagesLoaded) {
          final currentState = state as MessagesLoaded;
          final updatedMessages = [...currentState.messages, sentMessage];
          emit(MessagesLoaded(
            messages: updatedMessages,
            conversationId: currentState.conversationId,
          ));
        }
      },
    );
  }

  Future<void> _onMarkAsRead(
    MarkAsRead event,
    Emitter<MessagesState> emit,
  ) async {
    await messageRepository.markAsRead(event.conversationId, event.userUID);
    
    // Refresh conversations to update unread count
    if (state is ConversationsLoaded) {
      add(RefreshConversations(event.userUID));
    }
  }

  Future<void> _onRefreshConversations(
    RefreshConversations event,
    Emitter<MessagesState> emit,
  ) async {
    final result = await messageRepository.getConversations(event.userUID);
    
    result.fold(
      (failure) => emit(MessagesError('Failed to refresh conversations: ${failure.message}')),
      (conversations) async {
        final unreadResult = await messageRepository.getUnreadCount(event.userUID);
        final unreadCount = unreadResult.fold(
          (failure) => 0,
          (count) => count,
        );
        emit(ConversationsLoaded(
          conversations: conversations,
          unreadCount: unreadCount,
        ));
      },
    );
  }
}

