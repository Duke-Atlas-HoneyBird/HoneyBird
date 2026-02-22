// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimelineEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userUID) loadTimelinePosts,
    required TResult Function(String? userUID) refreshTimelinePosts,
    required TResult Function(String? userUID) loadMoreTimelinePosts,
    required TResult Function(Post post) updateTimelinePost,
    required TResult Function(String postId, String userUID) likePostInTimeline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userUID)? loadTimelinePosts,
    TResult? Function(String? userUID)? refreshTimelinePosts,
    TResult? Function(String? userUID)? loadMoreTimelinePosts,
    TResult? Function(Post post)? updateTimelinePost,
    TResult? Function(String postId, String userUID)? likePostInTimeline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userUID)? loadTimelinePosts,
    TResult Function(String? userUID)? refreshTimelinePosts,
    TResult Function(String? userUID)? loadMoreTimelinePosts,
    TResult Function(Post post)? updateTimelinePost,
    TResult Function(String postId, String userUID)? likePostInTimeline,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTimelinePosts value) loadTimelinePosts,
    required TResult Function(RefreshTimelinePosts value) refreshTimelinePosts,
    required TResult Function(LoadMoreTimelinePosts value)
        loadMoreTimelinePosts,
    required TResult Function(UpdateTimelinePost value) updateTimelinePost,
    required TResult Function(LikePostInTimeline value) likePostInTimeline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult? Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult? Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult? Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult? Function(LikePostInTimeline value)? likePostInTimeline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult Function(LikePostInTimeline value)? likePostInTimeline,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineEventCopyWith<$Res> {
  factory $TimelineEventCopyWith(
          TimelineEvent value, $Res Function(TimelineEvent) then) =
      _$TimelineEventCopyWithImpl<$Res, TimelineEvent>;
}

/// @nodoc
class _$TimelineEventCopyWithImpl<$Res, $Val extends TimelineEvent>
    implements $TimelineEventCopyWith<$Res> {
  _$TimelineEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadTimelinePostsImplCopyWith<$Res> {
  factory _$$LoadTimelinePostsImplCopyWith(_$LoadTimelinePostsImpl value,
          $Res Function(_$LoadTimelinePostsImpl) then) =
      __$$LoadTimelinePostsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? userUID});
}

/// @nodoc
class __$$LoadTimelinePostsImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$LoadTimelinePostsImpl>
    implements _$$LoadTimelinePostsImplCopyWith<$Res> {
  __$$LoadTimelinePostsImplCopyWithImpl(_$LoadTimelinePostsImpl _value,
      $Res Function(_$LoadTimelinePostsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = freezed,
  }) {
    return _then(_$LoadTimelinePostsImpl(
      userUID: freezed == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadTimelinePostsImpl implements LoadTimelinePosts {
  const _$LoadTimelinePostsImpl({this.userUID});

  @override
  final String? userUID;

  @override
  String toString() {
    return 'TimelineEvent.loadTimelinePosts(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadTimelinePostsImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadTimelinePostsImplCopyWith<_$LoadTimelinePostsImpl> get copyWith =>
      __$$LoadTimelinePostsImplCopyWithImpl<_$LoadTimelinePostsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userUID) loadTimelinePosts,
    required TResult Function(String? userUID) refreshTimelinePosts,
    required TResult Function(String? userUID) loadMoreTimelinePosts,
    required TResult Function(Post post) updateTimelinePost,
    required TResult Function(String postId, String userUID) likePostInTimeline,
  }) {
    return loadTimelinePosts(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userUID)? loadTimelinePosts,
    TResult? Function(String? userUID)? refreshTimelinePosts,
    TResult? Function(String? userUID)? loadMoreTimelinePosts,
    TResult? Function(Post post)? updateTimelinePost,
    TResult? Function(String postId, String userUID)? likePostInTimeline,
  }) {
    return loadTimelinePosts?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userUID)? loadTimelinePosts,
    TResult Function(String? userUID)? refreshTimelinePosts,
    TResult Function(String? userUID)? loadMoreTimelinePosts,
    TResult Function(Post post)? updateTimelinePost,
    TResult Function(String postId, String userUID)? likePostInTimeline,
    required TResult orElse(),
  }) {
    if (loadTimelinePosts != null) {
      return loadTimelinePosts(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTimelinePosts value) loadTimelinePosts,
    required TResult Function(RefreshTimelinePosts value) refreshTimelinePosts,
    required TResult Function(LoadMoreTimelinePosts value)
        loadMoreTimelinePosts,
    required TResult Function(UpdateTimelinePost value) updateTimelinePost,
    required TResult Function(LikePostInTimeline value) likePostInTimeline,
  }) {
    return loadTimelinePosts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult? Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult? Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult? Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult? Function(LikePostInTimeline value)? likePostInTimeline,
  }) {
    return loadTimelinePosts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult Function(LikePostInTimeline value)? likePostInTimeline,
    required TResult orElse(),
  }) {
    if (loadTimelinePosts != null) {
      return loadTimelinePosts(this);
    }
    return orElse();
  }
}

abstract class LoadTimelinePosts implements TimelineEvent {
  const factory LoadTimelinePosts({final String? userUID}) =
      _$LoadTimelinePostsImpl;

  String? get userUID;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadTimelinePostsImplCopyWith<_$LoadTimelinePostsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshTimelinePostsImplCopyWith<$Res> {
  factory _$$RefreshTimelinePostsImplCopyWith(_$RefreshTimelinePostsImpl value,
          $Res Function(_$RefreshTimelinePostsImpl) then) =
      __$$RefreshTimelinePostsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? userUID});
}

/// @nodoc
class __$$RefreshTimelinePostsImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$RefreshTimelinePostsImpl>
    implements _$$RefreshTimelinePostsImplCopyWith<$Res> {
  __$$RefreshTimelinePostsImplCopyWithImpl(_$RefreshTimelinePostsImpl _value,
      $Res Function(_$RefreshTimelinePostsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = freezed,
  }) {
    return _then(_$RefreshTimelinePostsImpl(
      userUID: freezed == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RefreshTimelinePostsImpl implements RefreshTimelinePosts {
  const _$RefreshTimelinePostsImpl({this.userUID});

  @override
  final String? userUID;

  @override
  String toString() {
    return 'TimelineEvent.refreshTimelinePosts(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTimelinePostsImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshTimelinePostsImplCopyWith<_$RefreshTimelinePostsImpl>
      get copyWith =>
          __$$RefreshTimelinePostsImplCopyWithImpl<_$RefreshTimelinePostsImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userUID) loadTimelinePosts,
    required TResult Function(String? userUID) refreshTimelinePosts,
    required TResult Function(String? userUID) loadMoreTimelinePosts,
    required TResult Function(Post post) updateTimelinePost,
    required TResult Function(String postId, String userUID) likePostInTimeline,
  }) {
    return refreshTimelinePosts(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userUID)? loadTimelinePosts,
    TResult? Function(String? userUID)? refreshTimelinePosts,
    TResult? Function(String? userUID)? loadMoreTimelinePosts,
    TResult? Function(Post post)? updateTimelinePost,
    TResult? Function(String postId, String userUID)? likePostInTimeline,
  }) {
    return refreshTimelinePosts?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userUID)? loadTimelinePosts,
    TResult Function(String? userUID)? refreshTimelinePosts,
    TResult Function(String? userUID)? loadMoreTimelinePosts,
    TResult Function(Post post)? updateTimelinePost,
    TResult Function(String postId, String userUID)? likePostInTimeline,
    required TResult orElse(),
  }) {
    if (refreshTimelinePosts != null) {
      return refreshTimelinePosts(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTimelinePosts value) loadTimelinePosts,
    required TResult Function(RefreshTimelinePosts value) refreshTimelinePosts,
    required TResult Function(LoadMoreTimelinePosts value)
        loadMoreTimelinePosts,
    required TResult Function(UpdateTimelinePost value) updateTimelinePost,
    required TResult Function(LikePostInTimeline value) likePostInTimeline,
  }) {
    return refreshTimelinePosts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult? Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult? Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult? Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult? Function(LikePostInTimeline value)? likePostInTimeline,
  }) {
    return refreshTimelinePosts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult Function(LikePostInTimeline value)? likePostInTimeline,
    required TResult orElse(),
  }) {
    if (refreshTimelinePosts != null) {
      return refreshTimelinePosts(this);
    }
    return orElse();
  }
}

abstract class RefreshTimelinePosts implements TimelineEvent {
  const factory RefreshTimelinePosts({final String? userUID}) =
      _$RefreshTimelinePostsImpl;

  String? get userUID;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshTimelinePostsImplCopyWith<_$RefreshTimelinePostsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMoreTimelinePostsImplCopyWith<$Res> {
  factory _$$LoadMoreTimelinePostsImplCopyWith(
          _$LoadMoreTimelinePostsImpl value,
          $Res Function(_$LoadMoreTimelinePostsImpl) then) =
      __$$LoadMoreTimelinePostsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? userUID});
}

/// @nodoc
class __$$LoadMoreTimelinePostsImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$LoadMoreTimelinePostsImpl>
    implements _$$LoadMoreTimelinePostsImplCopyWith<$Res> {
  __$$LoadMoreTimelinePostsImplCopyWithImpl(_$LoadMoreTimelinePostsImpl _value,
      $Res Function(_$LoadMoreTimelinePostsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = freezed,
  }) {
    return _then(_$LoadMoreTimelinePostsImpl(
      userUID: freezed == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadMoreTimelinePostsImpl implements LoadMoreTimelinePosts {
  const _$LoadMoreTimelinePostsImpl({this.userUID});

  @override
  final String? userUID;

  @override
  String toString() {
    return 'TimelineEvent.loadMoreTimelinePosts(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMoreTimelinePostsImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMoreTimelinePostsImplCopyWith<_$LoadMoreTimelinePostsImpl>
      get copyWith => __$$LoadMoreTimelinePostsImplCopyWithImpl<
          _$LoadMoreTimelinePostsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userUID) loadTimelinePosts,
    required TResult Function(String? userUID) refreshTimelinePosts,
    required TResult Function(String? userUID) loadMoreTimelinePosts,
    required TResult Function(Post post) updateTimelinePost,
    required TResult Function(String postId, String userUID) likePostInTimeline,
  }) {
    return loadMoreTimelinePosts(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userUID)? loadTimelinePosts,
    TResult? Function(String? userUID)? refreshTimelinePosts,
    TResult? Function(String? userUID)? loadMoreTimelinePosts,
    TResult? Function(Post post)? updateTimelinePost,
    TResult? Function(String postId, String userUID)? likePostInTimeline,
  }) {
    return loadMoreTimelinePosts?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userUID)? loadTimelinePosts,
    TResult Function(String? userUID)? refreshTimelinePosts,
    TResult Function(String? userUID)? loadMoreTimelinePosts,
    TResult Function(Post post)? updateTimelinePost,
    TResult Function(String postId, String userUID)? likePostInTimeline,
    required TResult orElse(),
  }) {
    if (loadMoreTimelinePosts != null) {
      return loadMoreTimelinePosts(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTimelinePosts value) loadTimelinePosts,
    required TResult Function(RefreshTimelinePosts value) refreshTimelinePosts,
    required TResult Function(LoadMoreTimelinePosts value)
        loadMoreTimelinePosts,
    required TResult Function(UpdateTimelinePost value) updateTimelinePost,
    required TResult Function(LikePostInTimeline value) likePostInTimeline,
  }) {
    return loadMoreTimelinePosts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult? Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult? Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult? Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult? Function(LikePostInTimeline value)? likePostInTimeline,
  }) {
    return loadMoreTimelinePosts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult Function(LikePostInTimeline value)? likePostInTimeline,
    required TResult orElse(),
  }) {
    if (loadMoreTimelinePosts != null) {
      return loadMoreTimelinePosts(this);
    }
    return orElse();
  }
}

abstract class LoadMoreTimelinePosts implements TimelineEvent {
  const factory LoadMoreTimelinePosts({final String? userUID}) =
      _$LoadMoreTimelinePostsImpl;

  String? get userUID;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadMoreTimelinePostsImplCopyWith<_$LoadMoreTimelinePostsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTimelinePostImplCopyWith<$Res> {
  factory _$$UpdateTimelinePostImplCopyWith(_$UpdateTimelinePostImpl value,
          $Res Function(_$UpdateTimelinePostImpl) then) =
      __$$UpdateTimelinePostImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Post post});
}

/// @nodoc
class __$$UpdateTimelinePostImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$UpdateTimelinePostImpl>
    implements _$$UpdateTimelinePostImplCopyWith<$Res> {
  __$$UpdateTimelinePostImplCopyWithImpl(_$UpdateTimelinePostImpl _value,
      $Res Function(_$UpdateTimelinePostImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
  }) {
    return _then(_$UpdateTimelinePostImpl(
      null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }
}

/// @nodoc

class _$UpdateTimelinePostImpl implements UpdateTimelinePost {
  const _$UpdateTimelinePostImpl(this.post);

  @override
  final Post post;

  @override
  String toString() {
    return 'TimelineEvent.updateTimelinePost(post: $post)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTimelinePostImpl &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTimelinePostImplCopyWith<_$UpdateTimelinePostImpl> get copyWith =>
      __$$UpdateTimelinePostImplCopyWithImpl<_$UpdateTimelinePostImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userUID) loadTimelinePosts,
    required TResult Function(String? userUID) refreshTimelinePosts,
    required TResult Function(String? userUID) loadMoreTimelinePosts,
    required TResult Function(Post post) updateTimelinePost,
    required TResult Function(String postId, String userUID) likePostInTimeline,
  }) {
    return updateTimelinePost(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userUID)? loadTimelinePosts,
    TResult? Function(String? userUID)? refreshTimelinePosts,
    TResult? Function(String? userUID)? loadMoreTimelinePosts,
    TResult? Function(Post post)? updateTimelinePost,
    TResult? Function(String postId, String userUID)? likePostInTimeline,
  }) {
    return updateTimelinePost?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userUID)? loadTimelinePosts,
    TResult Function(String? userUID)? refreshTimelinePosts,
    TResult Function(String? userUID)? loadMoreTimelinePosts,
    TResult Function(Post post)? updateTimelinePost,
    TResult Function(String postId, String userUID)? likePostInTimeline,
    required TResult orElse(),
  }) {
    if (updateTimelinePost != null) {
      return updateTimelinePost(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTimelinePosts value) loadTimelinePosts,
    required TResult Function(RefreshTimelinePosts value) refreshTimelinePosts,
    required TResult Function(LoadMoreTimelinePosts value)
        loadMoreTimelinePosts,
    required TResult Function(UpdateTimelinePost value) updateTimelinePost,
    required TResult Function(LikePostInTimeline value) likePostInTimeline,
  }) {
    return updateTimelinePost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult? Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult? Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult? Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult? Function(LikePostInTimeline value)? likePostInTimeline,
  }) {
    return updateTimelinePost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult Function(LikePostInTimeline value)? likePostInTimeline,
    required TResult orElse(),
  }) {
    if (updateTimelinePost != null) {
      return updateTimelinePost(this);
    }
    return orElse();
  }
}

abstract class UpdateTimelinePost implements TimelineEvent {
  const factory UpdateTimelinePost(final Post post) = _$UpdateTimelinePostImpl;

  Post get post;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTimelinePostImplCopyWith<_$UpdateTimelinePostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LikePostInTimelineImplCopyWith<$Res> {
  factory _$$LikePostInTimelineImplCopyWith(_$LikePostInTimelineImpl value,
          $Res Function(_$LikePostInTimelineImpl) then) =
      __$$LikePostInTimelineImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, String userUID});
}

/// @nodoc
class __$$LikePostInTimelineImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$LikePostInTimelineImpl>
    implements _$$LikePostInTimelineImplCopyWith<$Res> {
  __$$LikePostInTimelineImplCopyWithImpl(_$LikePostInTimelineImpl _value,
      $Res Function(_$LikePostInTimelineImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userUID = null,
  }) {
    return _then(_$LikePostInTimelineImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      userUID: null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LikePostInTimelineImpl implements LikePostInTimeline {
  const _$LikePostInTimelineImpl({required this.postId, required this.userUID});

  @override
  final String postId;
  @override
  final String userUID;

  @override
  String toString() {
    return 'TimelineEvent.likePostInTimeline(postId: $postId, userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikePostInTimelineImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, userUID);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LikePostInTimelineImplCopyWith<_$LikePostInTimelineImpl> get copyWith =>
      __$$LikePostInTimelineImplCopyWithImpl<_$LikePostInTimelineImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? userUID) loadTimelinePosts,
    required TResult Function(String? userUID) refreshTimelinePosts,
    required TResult Function(String? userUID) loadMoreTimelinePosts,
    required TResult Function(Post post) updateTimelinePost,
    required TResult Function(String postId, String userUID) likePostInTimeline,
  }) {
    return likePostInTimeline(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? userUID)? loadTimelinePosts,
    TResult? Function(String? userUID)? refreshTimelinePosts,
    TResult? Function(String? userUID)? loadMoreTimelinePosts,
    TResult? Function(Post post)? updateTimelinePost,
    TResult? Function(String postId, String userUID)? likePostInTimeline,
  }) {
    return likePostInTimeline?.call(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? userUID)? loadTimelinePosts,
    TResult Function(String? userUID)? refreshTimelinePosts,
    TResult Function(String? userUID)? loadMoreTimelinePosts,
    TResult Function(Post post)? updateTimelinePost,
    TResult Function(String postId, String userUID)? likePostInTimeline,
    required TResult orElse(),
  }) {
    if (likePostInTimeline != null) {
      return likePostInTimeline(postId, userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTimelinePosts value) loadTimelinePosts,
    required TResult Function(RefreshTimelinePosts value) refreshTimelinePosts,
    required TResult Function(LoadMoreTimelinePosts value)
        loadMoreTimelinePosts,
    required TResult Function(UpdateTimelinePost value) updateTimelinePost,
    required TResult Function(LikePostInTimeline value) likePostInTimeline,
  }) {
    return likePostInTimeline(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult? Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult? Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult? Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult? Function(LikePostInTimeline value)? likePostInTimeline,
  }) {
    return likePostInTimeline?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTimelinePosts value)? loadTimelinePosts,
    TResult Function(RefreshTimelinePosts value)? refreshTimelinePosts,
    TResult Function(LoadMoreTimelinePosts value)? loadMoreTimelinePosts,
    TResult Function(UpdateTimelinePost value)? updateTimelinePost,
    TResult Function(LikePostInTimeline value)? likePostInTimeline,
    required TResult orElse(),
  }) {
    if (likePostInTimeline != null) {
      return likePostInTimeline(this);
    }
    return orElse();
  }
}

abstract class LikePostInTimeline implements TimelineEvent {
  const factory LikePostInTimeline(
      {required final String postId,
      required final String userUID}) = _$LikePostInTimelineImpl;

  String get postId;
  String get userUID;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LikePostInTimelineImplCopyWith<_$LikePostInTimelineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
