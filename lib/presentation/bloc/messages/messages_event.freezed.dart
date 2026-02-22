// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messages_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessagesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadConversations,
    required TResult Function(String conversationId) loadMessages,
    required TResult Function(Message message, String? conversationId)
        sendMessage,
    required TResult Function(String conversationId, String userUID) markAsRead,
    required TResult Function(String userUID) refreshConversations,
    required TResult Function(String userUID) loadUnreadCount,
    required TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)
        openConversationWith,
    required TResult Function() clearOpenConversation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadConversations,
    TResult? Function(String conversationId)? loadMessages,
    TResult? Function(Message message, String? conversationId)? sendMessage,
    TResult? Function(String conversationId, String userUID)? markAsRead,
    TResult? Function(String userUID)? refreshConversations,
    TResult? Function(String userUID)? loadUnreadCount,
    TResult? Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult? Function()? clearOpenConversation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadConversations,
    TResult Function(String conversationId)? loadMessages,
    TResult Function(Message message, String? conversationId)? sendMessage,
    TResult Function(String conversationId, String userUID)? markAsRead,
    TResult Function(String userUID)? refreshConversations,
    TResult Function(String userUID)? loadUnreadCount,
    TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult Function()? clearOpenConversation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadConversations value) loadConversations,
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RefreshConversations value) refreshConversations,
    required TResult Function(LoadUnreadCount value) loadUnreadCount,
    required TResult Function(OpenConversationWith value) openConversationWith,
    required TResult Function(ClearOpenConversation value)
        clearOpenConversation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadConversations value)? loadConversations,
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RefreshConversations value)? refreshConversations,
    TResult? Function(LoadUnreadCount value)? loadUnreadCount,
    TResult? Function(OpenConversationWith value)? openConversationWith,
    TResult? Function(ClearOpenConversation value)? clearOpenConversation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadConversations value)? loadConversations,
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RefreshConversations value)? refreshConversations,
    TResult Function(LoadUnreadCount value)? loadUnreadCount,
    TResult Function(OpenConversationWith value)? openConversationWith,
    TResult Function(ClearOpenConversation value)? clearOpenConversation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagesEventCopyWith<$Res> {
  factory $MessagesEventCopyWith(
          MessagesEvent value, $Res Function(MessagesEvent) then) =
      _$MessagesEventCopyWithImpl<$Res, MessagesEvent>;
}

/// @nodoc
class _$MessagesEventCopyWithImpl<$Res, $Val extends MessagesEvent>
    implements $MessagesEventCopyWith<$Res> {
  _$MessagesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadConversationsImplCopyWith<$Res> {
  factory _$$LoadConversationsImplCopyWith(_$LoadConversationsImpl value,
          $Res Function(_$LoadConversationsImpl) then) =
      __$$LoadConversationsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userUID});
}

/// @nodoc
class __$$LoadConversationsImplCopyWithImpl<$Res>
    extends _$MessagesEventCopyWithImpl<$Res, _$LoadConversationsImpl>
    implements _$$LoadConversationsImplCopyWith<$Res> {
  __$$LoadConversationsImplCopyWithImpl(_$LoadConversationsImpl _value,
      $Res Function(_$LoadConversationsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = null,
  }) {
    return _then(_$LoadConversationsImpl(
      null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadConversationsImpl implements LoadConversations {
  const _$LoadConversationsImpl(this.userUID);

  @override
  final String userUID;

  @override
  String toString() {
    return 'MessagesEvent.loadConversations(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadConversationsImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadConversationsImplCopyWith<_$LoadConversationsImpl> get copyWith =>
      __$$LoadConversationsImplCopyWithImpl<_$LoadConversationsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadConversations,
    required TResult Function(String conversationId) loadMessages,
    required TResult Function(Message message, String? conversationId)
        sendMessage,
    required TResult Function(String conversationId, String userUID) markAsRead,
    required TResult Function(String userUID) refreshConversations,
    required TResult Function(String userUID) loadUnreadCount,
    required TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)
        openConversationWith,
    required TResult Function() clearOpenConversation,
  }) {
    return loadConversations(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadConversations,
    TResult? Function(String conversationId)? loadMessages,
    TResult? Function(Message message, String? conversationId)? sendMessage,
    TResult? Function(String conversationId, String userUID)? markAsRead,
    TResult? Function(String userUID)? refreshConversations,
    TResult? Function(String userUID)? loadUnreadCount,
    TResult? Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult? Function()? clearOpenConversation,
  }) {
    return loadConversations?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadConversations,
    TResult Function(String conversationId)? loadMessages,
    TResult Function(Message message, String? conversationId)? sendMessage,
    TResult Function(String conversationId, String userUID)? markAsRead,
    TResult Function(String userUID)? refreshConversations,
    TResult Function(String userUID)? loadUnreadCount,
    TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult Function()? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (loadConversations != null) {
      return loadConversations(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadConversations value) loadConversations,
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RefreshConversations value) refreshConversations,
    required TResult Function(LoadUnreadCount value) loadUnreadCount,
    required TResult Function(OpenConversationWith value) openConversationWith,
    required TResult Function(ClearOpenConversation value)
        clearOpenConversation,
  }) {
    return loadConversations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadConversations value)? loadConversations,
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RefreshConversations value)? refreshConversations,
    TResult? Function(LoadUnreadCount value)? loadUnreadCount,
    TResult? Function(OpenConversationWith value)? openConversationWith,
    TResult? Function(ClearOpenConversation value)? clearOpenConversation,
  }) {
    return loadConversations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadConversations value)? loadConversations,
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RefreshConversations value)? refreshConversations,
    TResult Function(LoadUnreadCount value)? loadUnreadCount,
    TResult Function(OpenConversationWith value)? openConversationWith,
    TResult Function(ClearOpenConversation value)? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (loadConversations != null) {
      return loadConversations(this);
    }
    return orElse();
  }
}

abstract class LoadConversations implements MessagesEvent {
  const factory LoadConversations(final String userUID) =
      _$LoadConversationsImpl;

  String get userUID;

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadConversationsImplCopyWith<_$LoadConversationsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMessagesImplCopyWith<$Res> {
  factory _$$LoadMessagesImplCopyWith(
          _$LoadMessagesImpl value, $Res Function(_$LoadMessagesImpl) then) =
      __$$LoadMessagesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId});
}

/// @nodoc
class __$$LoadMessagesImplCopyWithImpl<$Res>
    extends _$MessagesEventCopyWithImpl<$Res, _$LoadMessagesImpl>
    implements _$$LoadMessagesImplCopyWith<$Res> {
  __$$LoadMessagesImplCopyWithImpl(
      _$LoadMessagesImpl _value, $Res Function(_$LoadMessagesImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
  }) {
    return _then(_$LoadMessagesImpl(
      null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadMessagesImpl implements LoadMessages {
  const _$LoadMessagesImpl(this.conversationId);

  @override
  final String conversationId;

  @override
  String toString() {
    return 'MessagesEvent.loadMessages(conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMessagesImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMessagesImplCopyWith<_$LoadMessagesImpl> get copyWith =>
      __$$LoadMessagesImplCopyWithImpl<_$LoadMessagesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadConversations,
    required TResult Function(String conversationId) loadMessages,
    required TResult Function(Message message, String? conversationId)
        sendMessage,
    required TResult Function(String conversationId, String userUID) markAsRead,
    required TResult Function(String userUID) refreshConversations,
    required TResult Function(String userUID) loadUnreadCount,
    required TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)
        openConversationWith,
    required TResult Function() clearOpenConversation,
  }) {
    return loadMessages(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadConversations,
    TResult? Function(String conversationId)? loadMessages,
    TResult? Function(Message message, String? conversationId)? sendMessage,
    TResult? Function(String conversationId, String userUID)? markAsRead,
    TResult? Function(String userUID)? refreshConversations,
    TResult? Function(String userUID)? loadUnreadCount,
    TResult? Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult? Function()? clearOpenConversation,
  }) {
    return loadMessages?.call(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadConversations,
    TResult Function(String conversationId)? loadMessages,
    TResult Function(Message message, String? conversationId)? sendMessage,
    TResult Function(String conversationId, String userUID)? markAsRead,
    TResult Function(String userUID)? refreshConversations,
    TResult Function(String userUID)? loadUnreadCount,
    TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult Function()? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadConversations value) loadConversations,
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RefreshConversations value) refreshConversations,
    required TResult Function(LoadUnreadCount value) loadUnreadCount,
    required TResult Function(OpenConversationWith value) openConversationWith,
    required TResult Function(ClearOpenConversation value)
        clearOpenConversation,
  }) {
    return loadMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadConversations value)? loadConversations,
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RefreshConversations value)? refreshConversations,
    TResult? Function(LoadUnreadCount value)? loadUnreadCount,
    TResult? Function(OpenConversationWith value)? openConversationWith,
    TResult? Function(ClearOpenConversation value)? clearOpenConversation,
  }) {
    return loadMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadConversations value)? loadConversations,
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RefreshConversations value)? refreshConversations,
    TResult Function(LoadUnreadCount value)? loadUnreadCount,
    TResult Function(OpenConversationWith value)? openConversationWith,
    TResult Function(ClearOpenConversation value)? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(this);
    }
    return orElse();
  }
}

abstract class LoadMessages implements MessagesEvent {
  const factory LoadMessages(final String conversationId) = _$LoadMessagesImpl;

  String get conversationId;

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadMessagesImplCopyWith<_$LoadMessagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendMessageImplCopyWith<$Res> {
  factory _$$SendMessageImplCopyWith(
          _$SendMessageImpl value, $Res Function(_$SendMessageImpl) then) =
      __$$SendMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Message message, String? conversationId});
}

/// @nodoc
class __$$SendMessageImplCopyWithImpl<$Res>
    extends _$MessagesEventCopyWithImpl<$Res, _$SendMessageImpl>
    implements _$$SendMessageImplCopyWith<$Res> {
  __$$SendMessageImplCopyWithImpl(
      _$SendMessageImpl _value, $Res Function(_$SendMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? conversationId = freezed,
  }) {
    return _then(_$SendMessageImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SendMessageImpl implements SendMessage {
  const _$SendMessageImpl(this.message, {this.conversationId});

  @override
  final Message message;
  @override
  final String? conversationId;

  @override
  String toString() {
    return 'MessagesEvent.sendMessage(message: $message, conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, conversationId);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageImplCopyWith<_$SendMessageImpl> get copyWith =>
      __$$SendMessageImplCopyWithImpl<_$SendMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadConversations,
    required TResult Function(String conversationId) loadMessages,
    required TResult Function(Message message, String? conversationId)
        sendMessage,
    required TResult Function(String conversationId, String userUID) markAsRead,
    required TResult Function(String userUID) refreshConversations,
    required TResult Function(String userUID) loadUnreadCount,
    required TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)
        openConversationWith,
    required TResult Function() clearOpenConversation,
  }) {
    return sendMessage(message, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadConversations,
    TResult? Function(String conversationId)? loadMessages,
    TResult? Function(Message message, String? conversationId)? sendMessage,
    TResult? Function(String conversationId, String userUID)? markAsRead,
    TResult? Function(String userUID)? refreshConversations,
    TResult? Function(String userUID)? loadUnreadCount,
    TResult? Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult? Function()? clearOpenConversation,
  }) {
    return sendMessage?.call(message, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadConversations,
    TResult Function(String conversationId)? loadMessages,
    TResult Function(Message message, String? conversationId)? sendMessage,
    TResult Function(String conversationId, String userUID)? markAsRead,
    TResult Function(String userUID)? refreshConversations,
    TResult Function(String userUID)? loadUnreadCount,
    TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult Function()? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(message, conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadConversations value) loadConversations,
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RefreshConversations value) refreshConversations,
    required TResult Function(LoadUnreadCount value) loadUnreadCount,
    required TResult Function(OpenConversationWith value) openConversationWith,
    required TResult Function(ClearOpenConversation value)
        clearOpenConversation,
  }) {
    return sendMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadConversations value)? loadConversations,
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RefreshConversations value)? refreshConversations,
    TResult? Function(LoadUnreadCount value)? loadUnreadCount,
    TResult? Function(OpenConversationWith value)? openConversationWith,
    TResult? Function(ClearOpenConversation value)? clearOpenConversation,
  }) {
    return sendMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadConversations value)? loadConversations,
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RefreshConversations value)? refreshConversations,
    TResult Function(LoadUnreadCount value)? loadUnreadCount,
    TResult Function(OpenConversationWith value)? openConversationWith,
    TResult Function(ClearOpenConversation value)? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(this);
    }
    return orElse();
  }
}

abstract class SendMessage implements MessagesEvent {
  const factory SendMessage(final Message message,
      {final String? conversationId}) = _$SendMessageImpl;

  Message get message;
  String? get conversationId;

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMessageImplCopyWith<_$SendMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkAsReadImplCopyWith<$Res> {
  factory _$$MarkAsReadImplCopyWith(
          _$MarkAsReadImpl value, $Res Function(_$MarkAsReadImpl) then) =
      __$$MarkAsReadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String conversationId, String userUID});
}

/// @nodoc
class __$$MarkAsReadImplCopyWithImpl<$Res>
    extends _$MessagesEventCopyWithImpl<$Res, _$MarkAsReadImpl>
    implements _$$MarkAsReadImplCopyWith<$Res> {
  __$$MarkAsReadImplCopyWithImpl(
      _$MarkAsReadImpl _value, $Res Function(_$MarkAsReadImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? userUID = null,
  }) {
    return _then(_$MarkAsReadImpl(
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      userUID: null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MarkAsReadImpl implements MarkAsRead {
  const _$MarkAsReadImpl({required this.conversationId, required this.userUID});

  @override
  final String conversationId;
  @override
  final String userUID;

  @override
  String toString() {
    return 'MessagesEvent.markAsRead(conversationId: $conversationId, userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAsReadImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, userUID);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      __$$MarkAsReadImplCopyWithImpl<_$MarkAsReadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadConversations,
    required TResult Function(String conversationId) loadMessages,
    required TResult Function(Message message, String? conversationId)
        sendMessage,
    required TResult Function(String conversationId, String userUID) markAsRead,
    required TResult Function(String userUID) refreshConversations,
    required TResult Function(String userUID) loadUnreadCount,
    required TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)
        openConversationWith,
    required TResult Function() clearOpenConversation,
  }) {
    return markAsRead(conversationId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadConversations,
    TResult? Function(String conversationId)? loadMessages,
    TResult? Function(Message message, String? conversationId)? sendMessage,
    TResult? Function(String conversationId, String userUID)? markAsRead,
    TResult? Function(String userUID)? refreshConversations,
    TResult? Function(String userUID)? loadUnreadCount,
    TResult? Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult? Function()? clearOpenConversation,
  }) {
    return markAsRead?.call(conversationId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadConversations,
    TResult Function(String conversationId)? loadMessages,
    TResult Function(Message message, String? conversationId)? sendMessage,
    TResult Function(String conversationId, String userUID)? markAsRead,
    TResult Function(String userUID)? refreshConversations,
    TResult Function(String userUID)? loadUnreadCount,
    TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult Function()? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(conversationId, userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadConversations value) loadConversations,
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RefreshConversations value) refreshConversations,
    required TResult Function(LoadUnreadCount value) loadUnreadCount,
    required TResult Function(OpenConversationWith value) openConversationWith,
    required TResult Function(ClearOpenConversation value)
        clearOpenConversation,
  }) {
    return markAsRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadConversations value)? loadConversations,
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RefreshConversations value)? refreshConversations,
    TResult? Function(LoadUnreadCount value)? loadUnreadCount,
    TResult? Function(OpenConversationWith value)? openConversationWith,
    TResult? Function(ClearOpenConversation value)? clearOpenConversation,
  }) {
    return markAsRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadConversations value)? loadConversations,
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RefreshConversations value)? refreshConversations,
    TResult Function(LoadUnreadCount value)? loadUnreadCount,
    TResult Function(OpenConversationWith value)? openConversationWith,
    TResult Function(ClearOpenConversation value)? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(this);
    }
    return orElse();
  }
}

abstract class MarkAsRead implements MessagesEvent {
  const factory MarkAsRead(
      {required final String conversationId,
      required final String userUID}) = _$MarkAsReadImpl;

  String get conversationId;
  String get userUID;

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshConversationsImplCopyWith<$Res> {
  factory _$$RefreshConversationsImplCopyWith(_$RefreshConversationsImpl value,
          $Res Function(_$RefreshConversationsImpl) then) =
      __$$RefreshConversationsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userUID});
}

/// @nodoc
class __$$RefreshConversationsImplCopyWithImpl<$Res>
    extends _$MessagesEventCopyWithImpl<$Res, _$RefreshConversationsImpl>
    implements _$$RefreshConversationsImplCopyWith<$Res> {
  __$$RefreshConversationsImplCopyWithImpl(_$RefreshConversationsImpl _value,
      $Res Function(_$RefreshConversationsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = null,
  }) {
    return _then(_$RefreshConversationsImpl(
      null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RefreshConversationsImpl implements RefreshConversations {
  const _$RefreshConversationsImpl(this.userUID);

  @override
  final String userUID;

  @override
  String toString() {
    return 'MessagesEvent.refreshConversations(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshConversationsImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshConversationsImplCopyWith<_$RefreshConversationsImpl>
      get copyWith =>
          __$$RefreshConversationsImplCopyWithImpl<_$RefreshConversationsImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadConversations,
    required TResult Function(String conversationId) loadMessages,
    required TResult Function(Message message, String? conversationId)
        sendMessage,
    required TResult Function(String conversationId, String userUID) markAsRead,
    required TResult Function(String userUID) refreshConversations,
    required TResult Function(String userUID) loadUnreadCount,
    required TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)
        openConversationWith,
    required TResult Function() clearOpenConversation,
  }) {
    return refreshConversations(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadConversations,
    TResult? Function(String conversationId)? loadMessages,
    TResult? Function(Message message, String? conversationId)? sendMessage,
    TResult? Function(String conversationId, String userUID)? markAsRead,
    TResult? Function(String userUID)? refreshConversations,
    TResult? Function(String userUID)? loadUnreadCount,
    TResult? Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult? Function()? clearOpenConversation,
  }) {
    return refreshConversations?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadConversations,
    TResult Function(String conversationId)? loadMessages,
    TResult Function(Message message, String? conversationId)? sendMessage,
    TResult Function(String conversationId, String userUID)? markAsRead,
    TResult Function(String userUID)? refreshConversations,
    TResult Function(String userUID)? loadUnreadCount,
    TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult Function()? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (refreshConversations != null) {
      return refreshConversations(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadConversations value) loadConversations,
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RefreshConversations value) refreshConversations,
    required TResult Function(LoadUnreadCount value) loadUnreadCount,
    required TResult Function(OpenConversationWith value) openConversationWith,
    required TResult Function(ClearOpenConversation value)
        clearOpenConversation,
  }) {
    return refreshConversations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadConversations value)? loadConversations,
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RefreshConversations value)? refreshConversations,
    TResult? Function(LoadUnreadCount value)? loadUnreadCount,
    TResult? Function(OpenConversationWith value)? openConversationWith,
    TResult? Function(ClearOpenConversation value)? clearOpenConversation,
  }) {
    return refreshConversations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadConversations value)? loadConversations,
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RefreshConversations value)? refreshConversations,
    TResult Function(LoadUnreadCount value)? loadUnreadCount,
    TResult Function(OpenConversationWith value)? openConversationWith,
    TResult Function(ClearOpenConversation value)? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (refreshConversations != null) {
      return refreshConversations(this);
    }
    return orElse();
  }
}

abstract class RefreshConversations implements MessagesEvent {
  const factory RefreshConversations(final String userUID) =
      _$RefreshConversationsImpl;

  String get userUID;

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshConversationsImplCopyWith<_$RefreshConversationsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadUnreadCountImplCopyWith<$Res> {
  factory _$$LoadUnreadCountImplCopyWith(_$LoadUnreadCountImpl value,
          $Res Function(_$LoadUnreadCountImpl) then) =
      __$$LoadUnreadCountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userUID});
}

/// @nodoc
class __$$LoadUnreadCountImplCopyWithImpl<$Res>
    extends _$MessagesEventCopyWithImpl<$Res, _$LoadUnreadCountImpl>
    implements _$$LoadUnreadCountImplCopyWith<$Res> {
  __$$LoadUnreadCountImplCopyWithImpl(
      _$LoadUnreadCountImpl _value, $Res Function(_$LoadUnreadCountImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = null,
  }) {
    return _then(_$LoadUnreadCountImpl(
      null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadUnreadCountImpl implements LoadUnreadCount {
  const _$LoadUnreadCountImpl(this.userUID);

  @override
  final String userUID;

  @override
  String toString() {
    return 'MessagesEvent.loadUnreadCount(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadUnreadCountImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadUnreadCountImplCopyWith<_$LoadUnreadCountImpl> get copyWith =>
      __$$LoadUnreadCountImplCopyWithImpl<_$LoadUnreadCountImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadConversations,
    required TResult Function(String conversationId) loadMessages,
    required TResult Function(Message message, String? conversationId)
        sendMessage,
    required TResult Function(String conversationId, String userUID) markAsRead,
    required TResult Function(String userUID) refreshConversations,
    required TResult Function(String userUID) loadUnreadCount,
    required TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)
        openConversationWith,
    required TResult Function() clearOpenConversation,
  }) {
    return loadUnreadCount(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadConversations,
    TResult? Function(String conversationId)? loadMessages,
    TResult? Function(Message message, String? conversationId)? sendMessage,
    TResult? Function(String conversationId, String userUID)? markAsRead,
    TResult? Function(String userUID)? refreshConversations,
    TResult? Function(String userUID)? loadUnreadCount,
    TResult? Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult? Function()? clearOpenConversation,
  }) {
    return loadUnreadCount?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadConversations,
    TResult Function(String conversationId)? loadMessages,
    TResult Function(Message message, String? conversationId)? sendMessage,
    TResult Function(String conversationId, String userUID)? markAsRead,
    TResult Function(String userUID)? refreshConversations,
    TResult Function(String userUID)? loadUnreadCount,
    TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult Function()? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (loadUnreadCount != null) {
      return loadUnreadCount(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadConversations value) loadConversations,
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RefreshConversations value) refreshConversations,
    required TResult Function(LoadUnreadCount value) loadUnreadCount,
    required TResult Function(OpenConversationWith value) openConversationWith,
    required TResult Function(ClearOpenConversation value)
        clearOpenConversation,
  }) {
    return loadUnreadCount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadConversations value)? loadConversations,
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RefreshConversations value)? refreshConversations,
    TResult? Function(LoadUnreadCount value)? loadUnreadCount,
    TResult? Function(OpenConversationWith value)? openConversationWith,
    TResult? Function(ClearOpenConversation value)? clearOpenConversation,
  }) {
    return loadUnreadCount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadConversations value)? loadConversations,
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RefreshConversations value)? refreshConversations,
    TResult Function(LoadUnreadCount value)? loadUnreadCount,
    TResult Function(OpenConversationWith value)? openConversationWith,
    TResult Function(ClearOpenConversation value)? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (loadUnreadCount != null) {
      return loadUnreadCount(this);
    }
    return orElse();
  }
}

abstract class LoadUnreadCount implements MessagesEvent {
  const factory LoadUnreadCount(final String userUID) = _$LoadUnreadCountImpl;

  String get userUID;

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadUnreadCountImplCopyWith<_$LoadUnreadCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OpenConversationWithImplCopyWith<$Res> {
  factory _$$OpenConversationWithImplCopyWith(_$OpenConversationWithImpl value,
          $Res Function(_$OpenConversationWithImpl) then) =
      __$$OpenConversationWithImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String currentUserUID,
      String currentUserName,
      String otherUserUID,
      String otherUserName});
}

/// @nodoc
class __$$OpenConversationWithImplCopyWithImpl<$Res>
    extends _$MessagesEventCopyWithImpl<$Res, _$OpenConversationWithImpl>
    implements _$$OpenConversationWithImplCopyWith<$Res> {
  __$$OpenConversationWithImplCopyWithImpl(_$OpenConversationWithImpl _value,
      $Res Function(_$OpenConversationWithImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUserUID = null,
    Object? currentUserName = null,
    Object? otherUserUID = null,
    Object? otherUserName = null,
  }) {
    return _then(_$OpenConversationWithImpl(
      currentUserUID: null == currentUserUID
          ? _value.currentUserUID
          : currentUserUID // ignore: cast_nullable_to_non_nullable
              as String,
      currentUserName: null == currentUserName
          ? _value.currentUserName
          : currentUserName // ignore: cast_nullable_to_non_nullable
              as String,
      otherUserUID: null == otherUserUID
          ? _value.otherUserUID
          : otherUserUID // ignore: cast_nullable_to_non_nullable
              as String,
      otherUserName: null == otherUserName
          ? _value.otherUserName
          : otherUserName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OpenConversationWithImpl implements OpenConversationWith {
  const _$OpenConversationWithImpl(
      {required this.currentUserUID,
      required this.currentUserName,
      required this.otherUserUID,
      required this.otherUserName});

  @override
  final String currentUserUID;
  @override
  final String currentUserName;
  @override
  final String otherUserUID;
  @override
  final String otherUserName;

  @override
  String toString() {
    return 'MessagesEvent.openConversationWith(currentUserUID: $currentUserUID, currentUserName: $currentUserName, otherUserUID: $otherUserUID, otherUserName: $otherUserName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpenConversationWithImpl &&
            (identical(other.currentUserUID, currentUserUID) ||
                other.currentUserUID == currentUserUID) &&
            (identical(other.currentUserName, currentUserName) ||
                other.currentUserName == currentUserName) &&
            (identical(other.otherUserUID, otherUserUID) ||
                other.otherUserUID == otherUserUID) &&
            (identical(other.otherUserName, otherUserName) ||
                other.otherUserName == otherUserName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentUserUID, currentUserName,
      otherUserUID, otherUserName);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpenConversationWithImplCopyWith<_$OpenConversationWithImpl>
      get copyWith =>
          __$$OpenConversationWithImplCopyWithImpl<_$OpenConversationWithImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadConversations,
    required TResult Function(String conversationId) loadMessages,
    required TResult Function(Message message, String? conversationId)
        sendMessage,
    required TResult Function(String conversationId, String userUID) markAsRead,
    required TResult Function(String userUID) refreshConversations,
    required TResult Function(String userUID) loadUnreadCount,
    required TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)
        openConversationWith,
    required TResult Function() clearOpenConversation,
  }) {
    return openConversationWith(
        currentUserUID, currentUserName, otherUserUID, otherUserName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadConversations,
    TResult? Function(String conversationId)? loadMessages,
    TResult? Function(Message message, String? conversationId)? sendMessage,
    TResult? Function(String conversationId, String userUID)? markAsRead,
    TResult? Function(String userUID)? refreshConversations,
    TResult? Function(String userUID)? loadUnreadCount,
    TResult? Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult? Function()? clearOpenConversation,
  }) {
    return openConversationWith?.call(
        currentUserUID, currentUserName, otherUserUID, otherUserName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadConversations,
    TResult Function(String conversationId)? loadMessages,
    TResult Function(Message message, String? conversationId)? sendMessage,
    TResult Function(String conversationId, String userUID)? markAsRead,
    TResult Function(String userUID)? refreshConversations,
    TResult Function(String userUID)? loadUnreadCount,
    TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult Function()? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (openConversationWith != null) {
      return openConversationWith(
          currentUserUID, currentUserName, otherUserUID, otherUserName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadConversations value) loadConversations,
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RefreshConversations value) refreshConversations,
    required TResult Function(LoadUnreadCount value) loadUnreadCount,
    required TResult Function(OpenConversationWith value) openConversationWith,
    required TResult Function(ClearOpenConversation value)
        clearOpenConversation,
  }) {
    return openConversationWith(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadConversations value)? loadConversations,
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RefreshConversations value)? refreshConversations,
    TResult? Function(LoadUnreadCount value)? loadUnreadCount,
    TResult? Function(OpenConversationWith value)? openConversationWith,
    TResult? Function(ClearOpenConversation value)? clearOpenConversation,
  }) {
    return openConversationWith?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadConversations value)? loadConversations,
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RefreshConversations value)? refreshConversations,
    TResult Function(LoadUnreadCount value)? loadUnreadCount,
    TResult Function(OpenConversationWith value)? openConversationWith,
    TResult Function(ClearOpenConversation value)? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (openConversationWith != null) {
      return openConversationWith(this);
    }
    return orElse();
  }
}

abstract class OpenConversationWith implements MessagesEvent {
  const factory OpenConversationWith(
      {required final String currentUserUID,
      required final String currentUserName,
      required final String otherUserUID,
      required final String otherUserName}) = _$OpenConversationWithImpl;

  String get currentUserUID;
  String get currentUserName;
  String get otherUserUID;
  String get otherUserName;

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpenConversationWithImplCopyWith<_$OpenConversationWithImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearOpenConversationImplCopyWith<$Res> {
  factory _$$ClearOpenConversationImplCopyWith(
          _$ClearOpenConversationImpl value,
          $Res Function(_$ClearOpenConversationImpl) then) =
      __$$ClearOpenConversationImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearOpenConversationImplCopyWithImpl<$Res>
    extends _$MessagesEventCopyWithImpl<$Res, _$ClearOpenConversationImpl>
    implements _$$ClearOpenConversationImplCopyWith<$Res> {
  __$$ClearOpenConversationImplCopyWithImpl(_$ClearOpenConversationImpl _value,
      $Res Function(_$ClearOpenConversationImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearOpenConversationImpl implements ClearOpenConversation {
  const _$ClearOpenConversationImpl();

  @override
  String toString() {
    return 'MessagesEvent.clearOpenConversation()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClearOpenConversationImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadConversations,
    required TResult Function(String conversationId) loadMessages,
    required TResult Function(Message message, String? conversationId)
        sendMessage,
    required TResult Function(String conversationId, String userUID) markAsRead,
    required TResult Function(String userUID) refreshConversations,
    required TResult Function(String userUID) loadUnreadCount,
    required TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)
        openConversationWith,
    required TResult Function() clearOpenConversation,
  }) {
    return clearOpenConversation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadConversations,
    TResult? Function(String conversationId)? loadMessages,
    TResult? Function(Message message, String? conversationId)? sendMessage,
    TResult? Function(String conversationId, String userUID)? markAsRead,
    TResult? Function(String userUID)? refreshConversations,
    TResult? Function(String userUID)? loadUnreadCount,
    TResult? Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult? Function()? clearOpenConversation,
  }) {
    return clearOpenConversation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadConversations,
    TResult Function(String conversationId)? loadMessages,
    TResult Function(Message message, String? conversationId)? sendMessage,
    TResult Function(String conversationId, String userUID)? markAsRead,
    TResult Function(String userUID)? refreshConversations,
    TResult Function(String userUID)? loadUnreadCount,
    TResult Function(String currentUserUID, String currentUserName,
            String otherUserUID, String otherUserName)?
        openConversationWith,
    TResult Function()? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (clearOpenConversation != null) {
      return clearOpenConversation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadConversations value) loadConversations,
    required TResult Function(LoadMessages value) loadMessages,
    required TResult Function(SendMessage value) sendMessage,
    required TResult Function(MarkAsRead value) markAsRead,
    required TResult Function(RefreshConversations value) refreshConversations,
    required TResult Function(LoadUnreadCount value) loadUnreadCount,
    required TResult Function(OpenConversationWith value) openConversationWith,
    required TResult Function(ClearOpenConversation value)
        clearOpenConversation,
  }) {
    return clearOpenConversation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadConversations value)? loadConversations,
    TResult? Function(LoadMessages value)? loadMessages,
    TResult? Function(SendMessage value)? sendMessage,
    TResult? Function(MarkAsRead value)? markAsRead,
    TResult? Function(RefreshConversations value)? refreshConversations,
    TResult? Function(LoadUnreadCount value)? loadUnreadCount,
    TResult? Function(OpenConversationWith value)? openConversationWith,
    TResult? Function(ClearOpenConversation value)? clearOpenConversation,
  }) {
    return clearOpenConversation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadConversations value)? loadConversations,
    TResult Function(LoadMessages value)? loadMessages,
    TResult Function(SendMessage value)? sendMessage,
    TResult Function(MarkAsRead value)? markAsRead,
    TResult Function(RefreshConversations value)? refreshConversations,
    TResult Function(LoadUnreadCount value)? loadUnreadCount,
    TResult Function(OpenConversationWith value)? openConversationWith,
    TResult Function(ClearOpenConversation value)? clearOpenConversation,
    required TResult orElse(),
  }) {
    if (clearOpenConversation != null) {
      return clearOpenConversation(this);
    }
    return orElse();
  }
}

abstract class ClearOpenConversation implements MessagesEvent {
  const factory ClearOpenConversation() = _$ClearOpenConversationImpl;
}
