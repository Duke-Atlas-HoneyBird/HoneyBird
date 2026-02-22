// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FeedEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeedPosts,
    required TResult Function() refreshFeedPosts,
    required TResult Function(String category) filterFeedByCategory,
    required TResult Function(Post post) addOrUpdatePostToFeed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeedPosts,
    TResult? Function()? refreshFeedPosts,
    TResult? Function(String category)? filterFeedByCategory,
    TResult? Function(Post post)? addOrUpdatePostToFeed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeedPosts,
    TResult Function()? refreshFeedPosts,
    TResult Function(String category)? filterFeedByCategory,
    TResult Function(Post post)? addOrUpdatePostToFeed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFeedPosts value) loadFeedPosts,
    required TResult Function(RefreshFeedPosts value) refreshFeedPosts,
    required TResult Function(FilterFeedByCategory value) filterFeedByCategory,
    required TResult Function(AddOrUpdatePostToFeed value)
        addOrUpdatePostToFeed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFeedPosts value)? loadFeedPosts,
    TResult? Function(RefreshFeedPosts value)? refreshFeedPosts,
    TResult? Function(FilterFeedByCategory value)? filterFeedByCategory,
    TResult? Function(AddOrUpdatePostToFeed value)? addOrUpdatePostToFeed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFeedPosts value)? loadFeedPosts,
    TResult Function(RefreshFeedPosts value)? refreshFeedPosts,
    TResult Function(FilterFeedByCategory value)? filterFeedByCategory,
    TResult Function(AddOrUpdatePostToFeed value)? addOrUpdatePostToFeed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedEventCopyWith<$Res> {
  factory $FeedEventCopyWith(FeedEvent value, $Res Function(FeedEvent) then) =
      _$FeedEventCopyWithImpl<$Res, FeedEvent>;
}

/// @nodoc
class _$FeedEventCopyWithImpl<$Res, $Val extends FeedEvent>
    implements $FeedEventCopyWith<$Res> {
  _$FeedEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadFeedPostsImplCopyWith<$Res> {
  factory _$$LoadFeedPostsImplCopyWith(
          _$LoadFeedPostsImpl value, $Res Function(_$LoadFeedPostsImpl) then) =
      __$$LoadFeedPostsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadFeedPostsImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$LoadFeedPostsImpl>
    implements _$$LoadFeedPostsImplCopyWith<$Res> {
  __$$LoadFeedPostsImplCopyWithImpl(
      _$LoadFeedPostsImpl _value, $Res Function(_$LoadFeedPostsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeedEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadFeedPostsImpl implements LoadFeedPosts {
  const _$LoadFeedPostsImpl();

  @override
  String toString() {
    return 'FeedEvent.loadFeedPosts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadFeedPostsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeedPosts,
    required TResult Function() refreshFeedPosts,
    required TResult Function(String category) filterFeedByCategory,
    required TResult Function(Post post) addOrUpdatePostToFeed,
  }) {
    return loadFeedPosts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeedPosts,
    TResult? Function()? refreshFeedPosts,
    TResult? Function(String category)? filterFeedByCategory,
    TResult? Function(Post post)? addOrUpdatePostToFeed,
  }) {
    return loadFeedPosts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeedPosts,
    TResult Function()? refreshFeedPosts,
    TResult Function(String category)? filterFeedByCategory,
    TResult Function(Post post)? addOrUpdatePostToFeed,
    required TResult orElse(),
  }) {
    if (loadFeedPosts != null) {
      return loadFeedPosts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFeedPosts value) loadFeedPosts,
    required TResult Function(RefreshFeedPosts value) refreshFeedPosts,
    required TResult Function(FilterFeedByCategory value) filterFeedByCategory,
    required TResult Function(AddOrUpdatePostToFeed value)
        addOrUpdatePostToFeed,
  }) {
    return loadFeedPosts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFeedPosts value)? loadFeedPosts,
    TResult? Function(RefreshFeedPosts value)? refreshFeedPosts,
    TResult? Function(FilterFeedByCategory value)? filterFeedByCategory,
    TResult? Function(AddOrUpdatePostToFeed value)? addOrUpdatePostToFeed,
  }) {
    return loadFeedPosts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFeedPosts value)? loadFeedPosts,
    TResult Function(RefreshFeedPosts value)? refreshFeedPosts,
    TResult Function(FilterFeedByCategory value)? filterFeedByCategory,
    TResult Function(AddOrUpdatePostToFeed value)? addOrUpdatePostToFeed,
    required TResult orElse(),
  }) {
    if (loadFeedPosts != null) {
      return loadFeedPosts(this);
    }
    return orElse();
  }
}

abstract class LoadFeedPosts implements FeedEvent {
  const factory LoadFeedPosts() = _$LoadFeedPostsImpl;
}

/// @nodoc
abstract class _$$RefreshFeedPostsImplCopyWith<$Res> {
  factory _$$RefreshFeedPostsImplCopyWith(_$RefreshFeedPostsImpl value,
          $Res Function(_$RefreshFeedPostsImpl) then) =
      __$$RefreshFeedPostsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshFeedPostsImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$RefreshFeedPostsImpl>
    implements _$$RefreshFeedPostsImplCopyWith<$Res> {
  __$$RefreshFeedPostsImplCopyWithImpl(_$RefreshFeedPostsImpl _value,
      $Res Function(_$RefreshFeedPostsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeedEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshFeedPostsImpl implements RefreshFeedPosts {
  const _$RefreshFeedPostsImpl();

  @override
  String toString() {
    return 'FeedEvent.refreshFeedPosts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshFeedPostsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeedPosts,
    required TResult Function() refreshFeedPosts,
    required TResult Function(String category) filterFeedByCategory,
    required TResult Function(Post post) addOrUpdatePostToFeed,
  }) {
    return refreshFeedPosts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeedPosts,
    TResult? Function()? refreshFeedPosts,
    TResult? Function(String category)? filterFeedByCategory,
    TResult? Function(Post post)? addOrUpdatePostToFeed,
  }) {
    return refreshFeedPosts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeedPosts,
    TResult Function()? refreshFeedPosts,
    TResult Function(String category)? filterFeedByCategory,
    TResult Function(Post post)? addOrUpdatePostToFeed,
    required TResult orElse(),
  }) {
    if (refreshFeedPosts != null) {
      return refreshFeedPosts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFeedPosts value) loadFeedPosts,
    required TResult Function(RefreshFeedPosts value) refreshFeedPosts,
    required TResult Function(FilterFeedByCategory value) filterFeedByCategory,
    required TResult Function(AddOrUpdatePostToFeed value)
        addOrUpdatePostToFeed,
  }) {
    return refreshFeedPosts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFeedPosts value)? loadFeedPosts,
    TResult? Function(RefreshFeedPosts value)? refreshFeedPosts,
    TResult? Function(FilterFeedByCategory value)? filterFeedByCategory,
    TResult? Function(AddOrUpdatePostToFeed value)? addOrUpdatePostToFeed,
  }) {
    return refreshFeedPosts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFeedPosts value)? loadFeedPosts,
    TResult Function(RefreshFeedPosts value)? refreshFeedPosts,
    TResult Function(FilterFeedByCategory value)? filterFeedByCategory,
    TResult Function(AddOrUpdatePostToFeed value)? addOrUpdatePostToFeed,
    required TResult orElse(),
  }) {
    if (refreshFeedPosts != null) {
      return refreshFeedPosts(this);
    }
    return orElse();
  }
}

abstract class RefreshFeedPosts implements FeedEvent {
  const factory RefreshFeedPosts() = _$RefreshFeedPostsImpl;
}

/// @nodoc
abstract class _$$FilterFeedByCategoryImplCopyWith<$Res> {
  factory _$$FilterFeedByCategoryImplCopyWith(_$FilterFeedByCategoryImpl value,
          $Res Function(_$FilterFeedByCategoryImpl) then) =
      __$$FilterFeedByCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String category});
}

/// @nodoc
class __$$FilterFeedByCategoryImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$FilterFeedByCategoryImpl>
    implements _$$FilterFeedByCategoryImplCopyWith<$Res> {
  __$$FilterFeedByCategoryImplCopyWithImpl(_$FilterFeedByCategoryImpl _value,
      $Res Function(_$FilterFeedByCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
  }) {
    return _then(_$FilterFeedByCategoryImpl(
      null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FilterFeedByCategoryImpl implements FilterFeedByCategory {
  const _$FilterFeedByCategoryImpl(this.category);

  @override
  final String category;

  @override
  String toString() {
    return 'FeedEvent.filterFeedByCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterFeedByCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of FeedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterFeedByCategoryImplCopyWith<_$FilterFeedByCategoryImpl>
      get copyWith =>
          __$$FilterFeedByCategoryImplCopyWithImpl<_$FilterFeedByCategoryImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeedPosts,
    required TResult Function() refreshFeedPosts,
    required TResult Function(String category) filterFeedByCategory,
    required TResult Function(Post post) addOrUpdatePostToFeed,
  }) {
    return filterFeedByCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeedPosts,
    TResult? Function()? refreshFeedPosts,
    TResult? Function(String category)? filterFeedByCategory,
    TResult? Function(Post post)? addOrUpdatePostToFeed,
  }) {
    return filterFeedByCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeedPosts,
    TResult Function()? refreshFeedPosts,
    TResult Function(String category)? filterFeedByCategory,
    TResult Function(Post post)? addOrUpdatePostToFeed,
    required TResult orElse(),
  }) {
    if (filterFeedByCategory != null) {
      return filterFeedByCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFeedPosts value) loadFeedPosts,
    required TResult Function(RefreshFeedPosts value) refreshFeedPosts,
    required TResult Function(FilterFeedByCategory value) filterFeedByCategory,
    required TResult Function(AddOrUpdatePostToFeed value)
        addOrUpdatePostToFeed,
  }) {
    return filterFeedByCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFeedPosts value)? loadFeedPosts,
    TResult? Function(RefreshFeedPosts value)? refreshFeedPosts,
    TResult? Function(FilterFeedByCategory value)? filterFeedByCategory,
    TResult? Function(AddOrUpdatePostToFeed value)? addOrUpdatePostToFeed,
  }) {
    return filterFeedByCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFeedPosts value)? loadFeedPosts,
    TResult Function(RefreshFeedPosts value)? refreshFeedPosts,
    TResult Function(FilterFeedByCategory value)? filterFeedByCategory,
    TResult Function(AddOrUpdatePostToFeed value)? addOrUpdatePostToFeed,
    required TResult orElse(),
  }) {
    if (filterFeedByCategory != null) {
      return filterFeedByCategory(this);
    }
    return orElse();
  }
}

abstract class FilterFeedByCategory implements FeedEvent {
  const factory FilterFeedByCategory(final String category) =
      _$FilterFeedByCategoryImpl;

  String get category;

  /// Create a copy of FeedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterFeedByCategoryImplCopyWith<_$FilterFeedByCategoryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddOrUpdatePostToFeedImplCopyWith<$Res> {
  factory _$$AddOrUpdatePostToFeedImplCopyWith(
          _$AddOrUpdatePostToFeedImpl value,
          $Res Function(_$AddOrUpdatePostToFeedImpl) then) =
      __$$AddOrUpdatePostToFeedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Post post});
}

/// @nodoc
class __$$AddOrUpdatePostToFeedImplCopyWithImpl<$Res>
    extends _$FeedEventCopyWithImpl<$Res, _$AddOrUpdatePostToFeedImpl>
    implements _$$AddOrUpdatePostToFeedImplCopyWith<$Res> {
  __$$AddOrUpdatePostToFeedImplCopyWithImpl(_$AddOrUpdatePostToFeedImpl _value,
      $Res Function(_$AddOrUpdatePostToFeedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
  }) {
    return _then(_$AddOrUpdatePostToFeedImpl(
      null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }
}

/// @nodoc

class _$AddOrUpdatePostToFeedImpl implements AddOrUpdatePostToFeed {
  const _$AddOrUpdatePostToFeedImpl(this.post);

  @override
  final Post post;

  @override
  String toString() {
    return 'FeedEvent.addOrUpdatePostToFeed(post: $post)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddOrUpdatePostToFeedImpl &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  /// Create a copy of FeedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddOrUpdatePostToFeedImplCopyWith<_$AddOrUpdatePostToFeedImpl>
      get copyWith => __$$AddOrUpdatePostToFeedImplCopyWithImpl<
          _$AddOrUpdatePostToFeedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeedPosts,
    required TResult Function() refreshFeedPosts,
    required TResult Function(String category) filterFeedByCategory,
    required TResult Function(Post post) addOrUpdatePostToFeed,
  }) {
    return addOrUpdatePostToFeed(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeedPosts,
    TResult? Function()? refreshFeedPosts,
    TResult? Function(String category)? filterFeedByCategory,
    TResult? Function(Post post)? addOrUpdatePostToFeed,
  }) {
    return addOrUpdatePostToFeed?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeedPosts,
    TResult Function()? refreshFeedPosts,
    TResult Function(String category)? filterFeedByCategory,
    TResult Function(Post post)? addOrUpdatePostToFeed,
    required TResult orElse(),
  }) {
    if (addOrUpdatePostToFeed != null) {
      return addOrUpdatePostToFeed(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFeedPosts value) loadFeedPosts,
    required TResult Function(RefreshFeedPosts value) refreshFeedPosts,
    required TResult Function(FilterFeedByCategory value) filterFeedByCategory,
    required TResult Function(AddOrUpdatePostToFeed value)
        addOrUpdatePostToFeed,
  }) {
    return addOrUpdatePostToFeed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFeedPosts value)? loadFeedPosts,
    TResult? Function(RefreshFeedPosts value)? refreshFeedPosts,
    TResult? Function(FilterFeedByCategory value)? filterFeedByCategory,
    TResult? Function(AddOrUpdatePostToFeed value)? addOrUpdatePostToFeed,
  }) {
    return addOrUpdatePostToFeed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFeedPosts value)? loadFeedPosts,
    TResult Function(RefreshFeedPosts value)? refreshFeedPosts,
    TResult Function(FilterFeedByCategory value)? filterFeedByCategory,
    TResult Function(AddOrUpdatePostToFeed value)? addOrUpdatePostToFeed,
    required TResult orElse(),
  }) {
    if (addOrUpdatePostToFeed != null) {
      return addOrUpdatePostToFeed(this);
    }
    return orElse();
  }
}

abstract class AddOrUpdatePostToFeed implements FeedEvent {
  const factory AddOrUpdatePostToFeed(final Post post) =
      _$AddOrUpdatePostToFeedImpl;

  Post get post;

  /// Create a copy of FeedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddOrUpdatePostToFeedImplCopyWith<_$AddOrUpdatePostToFeedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
