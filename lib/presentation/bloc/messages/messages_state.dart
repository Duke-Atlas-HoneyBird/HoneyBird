import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/entities/restaurant.dart';

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
    @Default([]) List<Restaurant> restaurants,
    @Default(false) bool isLoadingRestaurants,
    /// When opening a restaurant conversation (new or existing)
    String? openWithRestaurantId,
    String? openWithRestaurantName,
  }) = _MessagesState;
}
