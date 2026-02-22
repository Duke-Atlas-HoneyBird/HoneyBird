// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_count_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CommentCountEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> postIds) loadCountsForPosts,
    required TResult Function(String postId, int count) countUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> postIds)? loadCountsForPosts,
    TResult? Function(String postId, int count)? countUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> postIds)? loadCountsForPosts,
    TResult Function(String postId, int count)? countUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCountsForPosts value) loadCountsForPosts,
    required TResult Function(CountUpdated value) countUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCountsForPosts value)? loadCountsForPosts,
    TResult? Function(CountUpdated value)? countUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCountsForPosts value)? loadCountsForPosts,
    TResult Function(CountUpdated value)? countUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCountEventCopyWith<$Res> {
  factory $CommentCountEventCopyWith(
          CommentCountEvent value, $Res Function(CommentCountEvent) then) =
      _$CommentCountEventCopyWithImpl<$Res, CommentCountEvent>;
}

/// @nodoc
class _$CommentCountEventCopyWithImpl<$Res, $Val extends CommentCountEvent>
    implements $CommentCountEventCopyWith<$Res> {
  _$CommentCountEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentCountEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadCountsForPostsImplCopyWith<$Res> {
  factory _$$LoadCountsForPostsImplCopyWith(_$LoadCountsForPostsImpl value,
          $Res Function(_$LoadCountsForPostsImpl) then) =
      __$$LoadCountsForPostsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> postIds});
}

/// @nodoc
class __$$LoadCountsForPostsImplCopyWithImpl<$Res>
    extends _$CommentCountEventCopyWithImpl<$Res, _$LoadCountsForPostsImpl>
    implements _$$LoadCountsForPostsImplCopyWith<$Res> {
  __$$LoadCountsForPostsImplCopyWithImpl(_$LoadCountsForPostsImpl _value,
      $Res Function(_$LoadCountsForPostsImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommentCountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postIds = null,
  }) {
    return _then(_$LoadCountsForPostsImpl(
      postIds: null == postIds
          ? _value._postIds
          : postIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$LoadCountsForPostsImpl implements LoadCountsForPosts {
  const _$LoadCountsForPostsImpl({required final List<String> postIds})
      : _postIds = postIds;

  final List<String> _postIds;
  @override
  List<String> get postIds {
    if (_postIds is EqualUnmodifiableListView) return _postIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_postIds);
  }

  @override
  String toString() {
    return 'CommentCountEvent.loadCountsForPosts(postIds: $postIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadCountsForPostsImpl &&
            const DeepCollectionEquality().equals(other._postIds, _postIds));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_postIds));

  /// Create a copy of CommentCountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadCountsForPostsImplCopyWith<_$LoadCountsForPostsImpl> get copyWith =>
      __$$LoadCountsForPostsImplCopyWithImpl<_$LoadCountsForPostsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> postIds) loadCountsForPosts,
    required TResult Function(String postId, int count) countUpdated,
  }) {
    return loadCountsForPosts(postIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> postIds)? loadCountsForPosts,
    TResult? Function(String postId, int count)? countUpdated,
  }) {
    return loadCountsForPosts?.call(postIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> postIds)? loadCountsForPosts,
    TResult Function(String postId, int count)? countUpdated,
    required TResult orElse(),
  }) {
    if (loadCountsForPosts != null) {
      return loadCountsForPosts(postIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCountsForPosts value) loadCountsForPosts,
    required TResult Function(CountUpdated value) countUpdated,
  }) {
    return loadCountsForPosts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCountsForPosts value)? loadCountsForPosts,
    TResult? Function(CountUpdated value)? countUpdated,
  }) {
    return loadCountsForPosts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCountsForPosts value)? loadCountsForPosts,
    TResult Function(CountUpdated value)? countUpdated,
    required TResult orElse(),
  }) {
    if (loadCountsForPosts != null) {
      return loadCountsForPosts(this);
    }
    return orElse();
  }
}

abstract class LoadCountsForPosts implements CommentCountEvent {
  const factory LoadCountsForPosts({required final List<String> postIds}) =
      _$LoadCountsForPostsImpl;

  List<String> get postIds;

  /// Create a copy of CommentCountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadCountsForPostsImplCopyWith<_$LoadCountsForPostsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CountUpdatedImplCopyWith<$Res> {
  factory _$$CountUpdatedImplCopyWith(
          _$CountUpdatedImpl value, $Res Function(_$CountUpdatedImpl) then) =
      __$$CountUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, int count});
}

/// @nodoc
class __$$CountUpdatedImplCopyWithImpl<$Res>
    extends _$CommentCountEventCopyWithImpl<$Res, _$CountUpdatedImpl>
    implements _$$CountUpdatedImplCopyWith<$Res> {
  __$$CountUpdatedImplCopyWithImpl(
      _$CountUpdatedImpl _value, $Res Function(_$CountUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommentCountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? count = null,
  }) {
    return _then(_$CountUpdatedImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CountUpdatedImpl implements CountUpdated {
  const _$CountUpdatedImpl({required this.postId, required this.count});

  @override
  final String postId;
  @override
  final int count;

  @override
  String toString() {
    return 'CommentCountEvent.countUpdated(postId: $postId, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountUpdatedImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, count);

  /// Create a copy of CommentCountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountUpdatedImplCopyWith<_$CountUpdatedImpl> get copyWith =>
      __$$CountUpdatedImplCopyWithImpl<_$CountUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> postIds) loadCountsForPosts,
    required TResult Function(String postId, int count) countUpdated,
  }) {
    return countUpdated(postId, count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> postIds)? loadCountsForPosts,
    TResult? Function(String postId, int count)? countUpdated,
  }) {
    return countUpdated?.call(postId, count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> postIds)? loadCountsForPosts,
    TResult Function(String postId, int count)? countUpdated,
    required TResult orElse(),
  }) {
    if (countUpdated != null) {
      return countUpdated(postId, count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCountsForPosts value) loadCountsForPosts,
    required TResult Function(CountUpdated value) countUpdated,
  }) {
    return countUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCountsForPosts value)? loadCountsForPosts,
    TResult? Function(CountUpdated value)? countUpdated,
  }) {
    return countUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCountsForPosts value)? loadCountsForPosts,
    TResult Function(CountUpdated value)? countUpdated,
    required TResult orElse(),
  }) {
    if (countUpdated != null) {
      return countUpdated(this);
    }
    return orElse();
  }
}

abstract class CountUpdated implements CommentCountEvent {
  const factory CountUpdated(
      {required final String postId,
      required final int count}) = _$CountUpdatedImpl;

  String get postId;
  int get count;

  /// Create a copy of CommentCountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountUpdatedImplCopyWith<_$CountUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
