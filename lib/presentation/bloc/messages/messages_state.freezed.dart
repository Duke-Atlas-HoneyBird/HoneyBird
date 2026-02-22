// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messages_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessagesState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<Conversation> get conversations => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// When opening conversation from profile (new or existing)
  String? get openWithUserUID => throw _privateConstructorUsedError;
  String? get openWithUserName => throw _privateConstructorUsedError;

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessagesStateCopyWith<MessagesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagesStateCopyWith<$Res> {
  factory $MessagesStateCopyWith(
          MessagesState value, $Res Function(MessagesState) then) =
      _$MessagesStateCopyWithImpl<$Res, MessagesState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<Conversation> conversations,
      int unreadCount,
      List<Message> messages,
      String conversationId,
      String? errorMessage,
      String? openWithUserUID,
      String? openWithUserName});
}

/// @nodoc
class _$MessagesStateCopyWithImpl<$Res, $Val extends MessagesState>
    implements $MessagesStateCopyWith<$Res> {
  _$MessagesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? conversations = null,
    Object? unreadCount = null,
    Object? messages = null,
    Object? conversationId = null,
    Object? errorMessage = freezed,
    Object? openWithUserUID = freezed,
    Object? openWithUserName = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      conversations: null == conversations
          ? _value.conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      openWithUserUID: freezed == openWithUserUID
          ? _value.openWithUserUID
          : openWithUserUID // ignore: cast_nullable_to_non_nullable
              as String?,
      openWithUserName: freezed == openWithUserName
          ? _value.openWithUserName
          : openWithUserName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessagesStateImplCopyWith<$Res>
    implements $MessagesStateCopyWith<$Res> {
  factory _$$MessagesStateImplCopyWith(
          _$MessagesStateImpl value, $Res Function(_$MessagesStateImpl) then) =
      __$$MessagesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<Conversation> conversations,
      int unreadCount,
      List<Message> messages,
      String conversationId,
      String? errorMessage,
      String? openWithUserUID,
      String? openWithUserName});
}

/// @nodoc
class __$$MessagesStateImplCopyWithImpl<$Res>
    extends _$MessagesStateCopyWithImpl<$Res, _$MessagesStateImpl>
    implements _$$MessagesStateImplCopyWith<$Res> {
  __$$MessagesStateImplCopyWithImpl(
      _$MessagesStateImpl _value, $Res Function(_$MessagesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? conversations = null,
    Object? unreadCount = null,
    Object? messages = null,
    Object? conversationId = null,
    Object? errorMessage = freezed,
    Object? openWithUserUID = freezed,
    Object? openWithUserName = freezed,
  }) {
    return _then(_$MessagesStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      conversations: null == conversations
          ? _value._conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      openWithUserUID: freezed == openWithUserUID
          ? _value.openWithUserUID
          : openWithUserUID // ignore: cast_nullable_to_non_nullable
              as String?,
      openWithUserName: freezed == openWithUserName
          ? _value.openWithUserName
          : openWithUserName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MessagesStateImpl implements _MessagesState {
  const _$MessagesStateImpl(
      {this.isLoading = false,
      final List<Conversation> conversations = const [],
      this.unreadCount = 0,
      final List<Message> messages = const [],
      this.conversationId = '',
      this.errorMessage,
      this.openWithUserUID,
      this.openWithUserName})
      : _conversations = conversations,
        _messages = messages;

  @override
  @JsonKey()
  final bool isLoading;
  final List<Conversation> _conversations;
  @override
  @JsonKey()
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  @JsonKey()
  final int unreadCount;
  final List<Message> _messages;
  @override
  @JsonKey()
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final String conversationId;
  @override
  final String? errorMessage;

  /// When opening conversation from profile (new or existing)
  @override
  final String? openWithUserUID;
  @override
  final String? openWithUserName;

  @override
  String toString() {
    return 'MessagesState(isLoading: $isLoading, conversations: $conversations, unreadCount: $unreadCount, messages: $messages, conversationId: $conversationId, errorMessage: $errorMessage, openWithUserUID: $openWithUserUID, openWithUserName: $openWithUserName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagesStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._conversations, _conversations) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.openWithUserUID, openWithUserUID) ||
                other.openWithUserUID == openWithUserUID) &&
            (identical(other.openWithUserName, openWithUserName) ||
                other.openWithUserName == openWithUserName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_conversations),
      unreadCount,
      const DeepCollectionEquality().hash(_messages),
      conversationId,
      errorMessage,
      openWithUserUID,
      openWithUserName);

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagesStateImplCopyWith<_$MessagesStateImpl> get copyWith =>
      __$$MessagesStateImplCopyWithImpl<_$MessagesStateImpl>(this, _$identity);
}

abstract class _MessagesState implements MessagesState {
  const factory _MessagesState(
      {final bool isLoading,
      final List<Conversation> conversations,
      final int unreadCount,
      final List<Message> messages,
      final String conversationId,
      final String? errorMessage,
      final String? openWithUserUID,
      final String? openWithUserName}) = _$MessagesStateImpl;

  @override
  bool get isLoading;
  @override
  List<Conversation> get conversations;
  @override
  int get unreadCount;
  @override
  List<Message> get messages;
  @override
  String get conversationId;
  @override
  String? get errorMessage;

  /// When opening conversation from profile (new or existing)
  @override
  String? get openWithUserUID;
  @override
  String? get openWithUserName;

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessagesStateImplCopyWith<_$MessagesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
