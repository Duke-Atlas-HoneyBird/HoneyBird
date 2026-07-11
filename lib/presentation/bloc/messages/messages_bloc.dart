import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_message_utils.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/repositories/message_repository.dart';
import '../../../domain/repositories/restaurant_repository.dart';
import 'messages_event.dart';
import 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessageRepository messageRepository;
  final RestaurantRepository restaurantRepository;

  MessagesBloc({
    required this.messageRepository,
    required this.restaurantRepository,
  }) : super(const MessagesState()) {
    on<LoadConversations>(_onLoadConversations);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<MarkAsRead>(_onMarkAsRead);
    on<RefreshConversations>(_onRefreshConversations);
    on<LoadUnreadCount>(_onLoadUnreadCount);
    on<LoadRestaurants>(_onLoadRestaurants);
    on<OpenConversationWithRestaurant>(_onOpenConversationWithRestaurant);
    on<ClearOpenConversation>(_onClearOpenConversation);
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
        errorMessage: ErrorMessageUtils.forUi('load_conversations'),
        conversations: [],
      )),
      (conversations) => emit(state.copyWith(
        isLoading: false,
        conversations: conversations,
        unreadCount:
            conversations.fold(0, (sum, chat) => sum + chat.unreadCount),
      )),
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
        errorMessage: ErrorMessageUtils.forUi('load_messages'),
        messages: [],
      )),
      (messages) => emit(state.copyWith(
        isLoading: false,
        messages: messages,
        conversationId: event.conversationId,
      )),
    );
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<MessagesState> emit,
  ) async {
    final result = await messageRepository.sendMessage(
      event.message,
      conversationId: event.conversationId,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        errorMessage: ErrorMessageUtils.forUi('send_message'),
      )),
      (sentMessage) => emit(state.copyWith(
        messages: [...state.messages, sentMessage],
        conversationId: state.conversationId,
      )),
    );
  }

  Future<void> _onMarkAsRead(
    MarkAsRead event,
    Emitter<MessagesState> emit,
  ) async {
    await messageRepository.markAsRead(event.conversationId, event.userUID);
    if (state.conversations.isNotEmpty) {
      add(MessagesEvent.refreshConversations(event.userUID));
    }
  }

  Future<void> _onOpenConversationWithRestaurant(
    OpenConversationWithRestaurant event,
    Emitter<MessagesState> emit,
  ) async {
    final convId =
        Conversation.idFor(event.userUID, event.restaurantId);

    final ensureResult = await messageRepository.ensureMerchantChannelNotice(
      userUID: event.userUID,
      userName: event.userName,
      restaurantId: event.restaurantId,
      restaurantName: event.restaurantName,
    );

    final ensureFailed = ensureResult.fold((_) => true, (_) => false);
    if (ensureFailed) {
      emit(state.copyWith(
        errorMessage: ErrorMessageUtils.forUi('open_conversation'),
      ));
      return;
    }

    emit(state.copyWith(
      conversationId: convId,
      messages: [],
      errorMessage: null,
      openWithRestaurantId: event.restaurantId,
      openWithRestaurantName: event.restaurantName,
    ));
    add(MessagesEvent.loadMessages(convId));
  }

  void _onClearOpenConversation(
    ClearOpenConversation event,
    Emitter<MessagesState> emit,
  ) {
    emit(state.copyWith(
      conversationId: '',
      messages: [],
      openWithRestaurantId: null,
      openWithRestaurantName: null,
    ));
  }

  Future<void> _onRefreshConversations(
    RefreshConversations event,
    Emitter<MessagesState> emit,
  ) async {
    final result = await messageRepository.getConversations(event.userUID);

    await result.fold(
      (failure) async => emit(state.copyWith(
        errorMessage: ErrorMessageUtils.forUi('refresh_conversations'),
      )),
      (conversations) async {
        final unreadResult =
            await messageRepository.getUnreadCount(event.userUID);
        final unreadCount =
            unreadResult.fold((failure) => 0, (count) => count);
        emit(state.copyWith(
          conversations: conversations,
          unreadCount: unreadCount,
        ));
      },
    );
  }

  Future<void> _onLoadUnreadCount(
    LoadUnreadCount event,
    Emitter<MessagesState> emit,
  ) async {
    final result = await messageRepository.getUnreadCount(event.userUID);
    final count = result.fold((failure) => 0, (c) => c);
    emit(state.copyWith(unreadCount: count));
  }

  Future<void> _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<MessagesState> emit,
  ) async {
    emit(state.copyWith(isLoadingRestaurants: true, errorMessage: null));

    final result = await restaurantRepository.getRestaurants();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingRestaurants: false,
        errorMessage: ErrorMessageUtils.forUi('load_restaurants'),
      )),
      (restaurants) => emit(state.copyWith(
        isLoadingRestaurants: false,
        restaurants: restaurants,
      )),
    );
  }
}
