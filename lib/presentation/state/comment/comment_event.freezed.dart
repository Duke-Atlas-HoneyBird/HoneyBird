// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CommentEvent {
  String get postId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String postId) loadRequested,
    required TResult Function(
            String postId, String text, String userName, String userUID)
        createRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String postId)? loadRequested,
    TResult? Function(
            String postId, String text, String userName, String userUID)?
        createRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String postId)? loadRequested,
    TResult Function(
            String postId, String text, String userName, String userUID)?
        createRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentsLoadRequested value) loadRequested,
    required TResult Function(CommentCreateRequested value) createRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentsLoadRequested value)? loadRequested,
    TResult? Function(CommentCreateRequested value)? createRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentsLoadRequested value)? loadRequested,
    TResult Function(CommentCreateRequested value)? createRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentEventCopyWith<CommentEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentEventCopyWith<$Res> {
  factory $CommentEventCopyWith(
          CommentEvent value, $Res Function(CommentEvent) then) =
      _$CommentEventCopyWithImpl<$Res, CommentEvent>;
  @useResult
  $Res call({String postId});
}

/// @nodoc
class _$CommentEventCopyWithImpl<$Res, $Val extends CommentEvent>
    implements $CommentEventCopyWith<$Res> {
  _$CommentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
  }) {
    return _then(_value.copyWith(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentsLoadRequestedImplCopyWith<$Res>
    implements $CommentEventCopyWith<$Res> {
  factory _$$CommentsLoadRequestedImplCopyWith(
          _$CommentsLoadRequestedImpl value,
          $Res Function(_$CommentsLoadRequestedImpl) then) =
      __$$CommentsLoadRequestedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String postId});
}

/// @nodoc
class __$$CommentsLoadRequestedImplCopyWithImpl<$Res>
    extends _$CommentEventCopyWithImpl<$Res, _$CommentsLoadRequestedImpl>
    implements _$$CommentsLoadRequestedImplCopyWith<$Res> {
  __$$CommentsLoadRequestedImplCopyWithImpl(_$CommentsLoadRequestedImpl _value,
      $Res Function(_$CommentsLoadRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
  }) {
    return _then(_$CommentsLoadRequestedImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CommentsLoadRequestedImpl implements CommentsLoadRequested {
  const _$CommentsLoadRequestedImpl({required this.postId});

  @override
  final String postId;

  @override
  String toString() {
    return 'CommentEvent.loadRequested(postId: $postId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentsLoadRequestedImpl &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId);

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentsLoadRequestedImplCopyWith<_$CommentsLoadRequestedImpl>
      get copyWith => __$$CommentsLoadRequestedImplCopyWithImpl<
          _$CommentsLoadRequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String postId) loadRequested,
    required TResult Function(
            String postId, String text, String userName, String userUID)
        createRequested,
  }) {
    return loadRequested(postId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String postId)? loadRequested,
    TResult? Function(
            String postId, String text, String userName, String userUID)?
        createRequested,
  }) {
    return loadRequested?.call(postId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String postId)? loadRequested,
    TResult Function(
            String postId, String text, String userName, String userUID)?
        createRequested,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(postId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentsLoadRequested value) loadRequested,
    required TResult Function(CommentCreateRequested value) createRequested,
  }) {
    return loadRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentsLoadRequested value)? loadRequested,
    TResult? Function(CommentCreateRequested value)? createRequested,
  }) {
    return loadRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentsLoadRequested value)? loadRequested,
    TResult Function(CommentCreateRequested value)? createRequested,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(this);
    }
    return orElse();
  }
}

abstract class CommentsLoadRequested implements CommentEvent {
  const factory CommentsLoadRequested({required final String postId}) =
      _$CommentsLoadRequestedImpl;

  @override
  String get postId;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentsLoadRequestedImplCopyWith<_$CommentsLoadRequestedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CommentCreateRequestedImplCopyWith<$Res>
    implements $CommentEventCopyWith<$Res> {
  factory _$$CommentCreateRequestedImplCopyWith(
          _$CommentCreateRequestedImpl value,
          $Res Function(_$CommentCreateRequestedImpl) then) =
      __$$CommentCreateRequestedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String postId, String text, String userName, String userUID});
}

/// @nodoc
class __$$CommentCreateRequestedImplCopyWithImpl<$Res>
    extends _$CommentEventCopyWithImpl<$Res, _$CommentCreateRequestedImpl>
    implements _$$CommentCreateRequestedImplCopyWith<$Res> {
  __$$CommentCreateRequestedImplCopyWithImpl(
      _$CommentCreateRequestedImpl _value,
      $Res Function(_$CommentCreateRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? text = null,
    Object? userName = null,
    Object? userUID = null,
  }) {
    return _then(_$CommentCreateRequestedImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userUID: null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CommentCreateRequestedImpl implements CommentCreateRequested {
  const _$CommentCreateRequestedImpl(
      {required this.postId,
      required this.text,
      required this.userName,
      required this.userUID});

  @override
  final String postId;
  @override
  final String text;
  @override
  final String userName;
  @override
  final String userUID;

  @override
  String toString() {
    return 'CommentEvent.createRequested(postId: $postId, text: $text, userName: $userName, userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentCreateRequestedImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, text, userName, userUID);

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentCreateRequestedImplCopyWith<_$CommentCreateRequestedImpl>
      get copyWith => __$$CommentCreateRequestedImplCopyWithImpl<
          _$CommentCreateRequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String postId) loadRequested,
    required TResult Function(
            String postId, String text, String userName, String userUID)
        createRequested,
  }) {
    return createRequested(postId, text, userName, userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String postId)? loadRequested,
    TResult? Function(
            String postId, String text, String userName, String userUID)?
        createRequested,
  }) {
    return createRequested?.call(postId, text, userName, userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String postId)? loadRequested,
    TResult Function(
            String postId, String text, String userName, String userUID)?
        createRequested,
    required TResult orElse(),
  }) {
    if (createRequested != null) {
      return createRequested(postId, text, userName, userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CommentsLoadRequested value) loadRequested,
    required TResult Function(CommentCreateRequested value) createRequested,
  }) {
    return createRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CommentsLoadRequested value)? loadRequested,
    TResult? Function(CommentCreateRequested value)? createRequested,
  }) {
    return createRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CommentsLoadRequested value)? loadRequested,
    TResult Function(CommentCreateRequested value)? createRequested,
    required TResult orElse(),
  }) {
    if (createRequested != null) {
      return createRequested(this);
    }
    return orElse();
  }
}

abstract class CommentCreateRequested implements CommentEvent {
  const factory CommentCreateRequested(
      {required final String postId,
      required final String text,
      required final String userName,
      required final String userUID}) = _$CommentCreateRequestedImpl;

  @override
  String get postId;
  String get text;
  String get userName;
  String get userUID;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentCreateRequestedImplCopyWith<_$CommentCreateRequestedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
