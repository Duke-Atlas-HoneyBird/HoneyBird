// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FavoritesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadFavoritePosts,
    required TResult Function(String postId, String userUID) addToFavorites,
    required TResult Function(String postId, String userUID)
        removeFromFavorites,
    required TResult Function(String userUID) refreshFavoritePosts,
    required TResult Function(String postId, String userUID) unstarPost,
    required TResult Function() clearFavorites,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadFavoritePosts,
    TResult? Function(String postId, String userUID)? addToFavorites,
    TResult? Function(String postId, String userUID)? removeFromFavorites,
    TResult? Function(String userUID)? refreshFavoritePosts,
    TResult? Function(String postId, String userUID)? unstarPost,
    TResult? Function()? clearFavorites,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadFavoritePosts,
    TResult Function(String postId, String userUID)? addToFavorites,
    TResult Function(String postId, String userUID)? removeFromFavorites,
    TResult Function(String userUID)? refreshFavoritePosts,
    TResult Function(String postId, String userUID)? unstarPost,
    TResult Function()? clearFavorites,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavoritePosts value) loadFavoritePosts,
    required TResult Function(AddToFavorites value) addToFavorites,
    required TResult Function(RemoveFromFavorites value) removeFromFavorites,
    required TResult Function(RefreshFavoritePosts value) refreshFavoritePosts,
    required TResult Function(UnstarPost value) unstarPost,
    required TResult Function(ClearFavorites value) clearFavorites,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult? Function(AddToFavorites value)? addToFavorites,
    TResult? Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult? Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult? Function(UnstarPost value)? unstarPost,
    TResult? Function(ClearFavorites value)? clearFavorites,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult Function(AddToFavorites value)? addToFavorites,
    TResult Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult Function(UnstarPost value)? unstarPost,
    TResult Function(ClearFavorites value)? clearFavorites,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritesEventCopyWith<$Res> {
  factory $FavoritesEventCopyWith(
          FavoritesEvent value, $Res Function(FavoritesEvent) then) =
      _$FavoritesEventCopyWithImpl<$Res, FavoritesEvent>;
}

/// @nodoc
class _$FavoritesEventCopyWithImpl<$Res, $Val extends FavoritesEvent>
    implements $FavoritesEventCopyWith<$Res> {
  _$FavoritesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadFavoritePostsImplCopyWith<$Res> {
  factory _$$LoadFavoritePostsImplCopyWith(_$LoadFavoritePostsImpl value,
          $Res Function(_$LoadFavoritePostsImpl) then) =
      __$$LoadFavoritePostsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userUID});
}

/// @nodoc
class __$$LoadFavoritePostsImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$LoadFavoritePostsImpl>
    implements _$$LoadFavoritePostsImplCopyWith<$Res> {
  __$$LoadFavoritePostsImplCopyWithImpl(_$LoadFavoritePostsImpl _value,
      $Res Function(_$LoadFavoritePostsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = null,
  }) {
    return _then(_$LoadFavoritePostsImpl(
      null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadFavoritePostsImpl implements LoadFavoritePosts {
  const _$LoadFavoritePostsImpl(this.userUID);

  @override
  final String userUID;

  @override
  String toString() {
    return 'FavoritesEvent.loadFavoritePosts(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadFavoritePostsImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadFavoritePostsImplCopyWith<_$LoadFavoritePostsImpl> get copyWith =>
      __$$LoadFavoritePostsImplCopyWithImpl<_$LoadFavoritePostsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadFavoritePosts,
    required TResult Function(String postId, String userUID) addToFavorites,
    required TResult Function(String postId, String userUID)
        removeFromFavorites,
    required TResult Function(String userUID) refreshFavoritePosts,
    required TResult Function(String postId, String userUID) unstarPost,
    required TResult Function() clearFavorites,
  }) {
    return loadFavoritePosts(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadFavoritePosts,
    TResult? Function(String postId, String userUID)? addToFavorites,
    TResult? Function(String postId, String userUID)? removeFromFavorites,
    TResult? Function(String userUID)? refreshFavoritePosts,
    TResult? Function(String postId, String userUID)? unstarPost,
    TResult? Function()? clearFavorites,
  }) {
    return loadFavoritePosts?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadFavoritePosts,
    TResult Function(String postId, String userUID)? addToFavorites,
    TResult Function(String postId, String userUID)? removeFromFavorites,
    TResult Function(String userUID)? refreshFavoritePosts,
    TResult Function(String postId, String userUID)? unstarPost,
    TResult Function()? clearFavorites,
    required TResult orElse(),
  }) {
    if (loadFavoritePosts != null) {
      return loadFavoritePosts(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavoritePosts value) loadFavoritePosts,
    required TResult Function(AddToFavorites value) addToFavorites,
    required TResult Function(RemoveFromFavorites value) removeFromFavorites,
    required TResult Function(RefreshFavoritePosts value) refreshFavoritePosts,
    required TResult Function(UnstarPost value) unstarPost,
    required TResult Function(ClearFavorites value) clearFavorites,
  }) {
    return loadFavoritePosts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult? Function(AddToFavorites value)? addToFavorites,
    TResult? Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult? Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult? Function(UnstarPost value)? unstarPost,
    TResult? Function(ClearFavorites value)? clearFavorites,
  }) {
    return loadFavoritePosts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult Function(AddToFavorites value)? addToFavorites,
    TResult Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult Function(UnstarPost value)? unstarPost,
    TResult Function(ClearFavorites value)? clearFavorites,
    required TResult orElse(),
  }) {
    if (loadFavoritePosts != null) {
      return loadFavoritePosts(this);
    }
    return orElse();
  }
}

abstract class LoadFavoritePosts implements FavoritesEvent {
  const factory LoadFavoritePosts(final String userUID) =
      _$LoadFavoritePostsImpl;

  String get userUID;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadFavoritePostsImplCopyWith<_$LoadFavoritePostsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddToFavoritesImplCopyWith<$Res> {
  factory _$$AddToFavoritesImplCopyWith(_$AddToFavoritesImpl value,
          $Res Function(_$AddToFavoritesImpl) then) =
      __$$AddToFavoritesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, String userUID});
}

/// @nodoc
class __$$AddToFavoritesImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$AddToFavoritesImpl>
    implements _$$AddToFavoritesImplCopyWith<$Res> {
  __$$AddToFavoritesImplCopyWithImpl(
      _$AddToFavoritesImpl _value, $Res Function(_$AddToFavoritesImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userUID = null,
  }) {
    return _then(_$AddToFavoritesImpl(
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

class _$AddToFavoritesImpl implements AddToFavorites {
  const _$AddToFavoritesImpl({required this.postId, required this.userUID});

  @override
  final String postId;
  @override
  final String userUID;

  @override
  String toString() {
    return 'FavoritesEvent.addToFavorites(postId: $postId, userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddToFavoritesImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, userUID);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddToFavoritesImplCopyWith<_$AddToFavoritesImpl> get copyWith =>
      __$$AddToFavoritesImplCopyWithImpl<_$AddToFavoritesImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadFavoritePosts,
    required TResult Function(String postId, String userUID) addToFavorites,
    required TResult Function(String postId, String userUID)
        removeFromFavorites,
    required TResult Function(String userUID) refreshFavoritePosts,
    required TResult Function(String postId, String userUID) unstarPost,
    required TResult Function() clearFavorites,
  }) {
    return addToFavorites(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadFavoritePosts,
    TResult? Function(String postId, String userUID)? addToFavorites,
    TResult? Function(String postId, String userUID)? removeFromFavorites,
    TResult? Function(String userUID)? refreshFavoritePosts,
    TResult? Function(String postId, String userUID)? unstarPost,
    TResult? Function()? clearFavorites,
  }) {
    return addToFavorites?.call(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadFavoritePosts,
    TResult Function(String postId, String userUID)? addToFavorites,
    TResult Function(String postId, String userUID)? removeFromFavorites,
    TResult Function(String userUID)? refreshFavoritePosts,
    TResult Function(String postId, String userUID)? unstarPost,
    TResult Function()? clearFavorites,
    required TResult orElse(),
  }) {
    if (addToFavorites != null) {
      return addToFavorites(postId, userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavoritePosts value) loadFavoritePosts,
    required TResult Function(AddToFavorites value) addToFavorites,
    required TResult Function(RemoveFromFavorites value) removeFromFavorites,
    required TResult Function(RefreshFavoritePosts value) refreshFavoritePosts,
    required TResult Function(UnstarPost value) unstarPost,
    required TResult Function(ClearFavorites value) clearFavorites,
  }) {
    return addToFavorites(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult? Function(AddToFavorites value)? addToFavorites,
    TResult? Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult? Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult? Function(UnstarPost value)? unstarPost,
    TResult? Function(ClearFavorites value)? clearFavorites,
  }) {
    return addToFavorites?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult Function(AddToFavorites value)? addToFavorites,
    TResult Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult Function(UnstarPost value)? unstarPost,
    TResult Function(ClearFavorites value)? clearFavorites,
    required TResult orElse(),
  }) {
    if (addToFavorites != null) {
      return addToFavorites(this);
    }
    return orElse();
  }
}

abstract class AddToFavorites implements FavoritesEvent {
  const factory AddToFavorites(
      {required final String postId,
      required final String userUID}) = _$AddToFavoritesImpl;

  String get postId;
  String get userUID;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddToFavoritesImplCopyWith<_$AddToFavoritesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveFromFavoritesImplCopyWith<$Res> {
  factory _$$RemoveFromFavoritesImplCopyWith(_$RemoveFromFavoritesImpl value,
          $Res Function(_$RemoveFromFavoritesImpl) then) =
      __$$RemoveFromFavoritesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, String userUID});
}

/// @nodoc
class __$$RemoveFromFavoritesImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$RemoveFromFavoritesImpl>
    implements _$$RemoveFromFavoritesImplCopyWith<$Res> {
  __$$RemoveFromFavoritesImplCopyWithImpl(_$RemoveFromFavoritesImpl _value,
      $Res Function(_$RemoveFromFavoritesImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userUID = null,
  }) {
    return _then(_$RemoveFromFavoritesImpl(
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

class _$RemoveFromFavoritesImpl implements RemoveFromFavorites {
  const _$RemoveFromFavoritesImpl(
      {required this.postId, required this.userUID});

  @override
  final String postId;
  @override
  final String userUID;

  @override
  String toString() {
    return 'FavoritesEvent.removeFromFavorites(postId: $postId, userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveFromFavoritesImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, userUID);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveFromFavoritesImplCopyWith<_$RemoveFromFavoritesImpl> get copyWith =>
      __$$RemoveFromFavoritesImplCopyWithImpl<_$RemoveFromFavoritesImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadFavoritePosts,
    required TResult Function(String postId, String userUID) addToFavorites,
    required TResult Function(String postId, String userUID)
        removeFromFavorites,
    required TResult Function(String userUID) refreshFavoritePosts,
    required TResult Function(String postId, String userUID) unstarPost,
    required TResult Function() clearFavorites,
  }) {
    return removeFromFavorites(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadFavoritePosts,
    TResult? Function(String postId, String userUID)? addToFavorites,
    TResult? Function(String postId, String userUID)? removeFromFavorites,
    TResult? Function(String userUID)? refreshFavoritePosts,
    TResult? Function(String postId, String userUID)? unstarPost,
    TResult? Function()? clearFavorites,
  }) {
    return removeFromFavorites?.call(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadFavoritePosts,
    TResult Function(String postId, String userUID)? addToFavorites,
    TResult Function(String postId, String userUID)? removeFromFavorites,
    TResult Function(String userUID)? refreshFavoritePosts,
    TResult Function(String postId, String userUID)? unstarPost,
    TResult Function()? clearFavorites,
    required TResult orElse(),
  }) {
    if (removeFromFavorites != null) {
      return removeFromFavorites(postId, userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavoritePosts value) loadFavoritePosts,
    required TResult Function(AddToFavorites value) addToFavorites,
    required TResult Function(RemoveFromFavorites value) removeFromFavorites,
    required TResult Function(RefreshFavoritePosts value) refreshFavoritePosts,
    required TResult Function(UnstarPost value) unstarPost,
    required TResult Function(ClearFavorites value) clearFavorites,
  }) {
    return removeFromFavorites(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult? Function(AddToFavorites value)? addToFavorites,
    TResult? Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult? Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult? Function(UnstarPost value)? unstarPost,
    TResult? Function(ClearFavorites value)? clearFavorites,
  }) {
    return removeFromFavorites?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult Function(AddToFavorites value)? addToFavorites,
    TResult Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult Function(UnstarPost value)? unstarPost,
    TResult Function(ClearFavorites value)? clearFavorites,
    required TResult orElse(),
  }) {
    if (removeFromFavorites != null) {
      return removeFromFavorites(this);
    }
    return orElse();
  }
}

abstract class RemoveFromFavorites implements FavoritesEvent {
  const factory RemoveFromFavorites(
      {required final String postId,
      required final String userUID}) = _$RemoveFromFavoritesImpl;

  String get postId;
  String get userUID;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveFromFavoritesImplCopyWith<_$RemoveFromFavoritesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshFavoritePostsImplCopyWith<$Res> {
  factory _$$RefreshFavoritePostsImplCopyWith(_$RefreshFavoritePostsImpl value,
          $Res Function(_$RefreshFavoritePostsImpl) then) =
      __$$RefreshFavoritePostsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userUID});
}

/// @nodoc
class __$$RefreshFavoritePostsImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$RefreshFavoritePostsImpl>
    implements _$$RefreshFavoritePostsImplCopyWith<$Res> {
  __$$RefreshFavoritePostsImplCopyWithImpl(_$RefreshFavoritePostsImpl _value,
      $Res Function(_$RefreshFavoritePostsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = null,
  }) {
    return _then(_$RefreshFavoritePostsImpl(
      null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RefreshFavoritePostsImpl implements RefreshFavoritePosts {
  const _$RefreshFavoritePostsImpl(this.userUID);

  @override
  final String userUID;

  @override
  String toString() {
    return 'FavoritesEvent.refreshFavoritePosts(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshFavoritePostsImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshFavoritePostsImplCopyWith<_$RefreshFavoritePostsImpl>
      get copyWith =>
          __$$RefreshFavoritePostsImplCopyWithImpl<_$RefreshFavoritePostsImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadFavoritePosts,
    required TResult Function(String postId, String userUID) addToFavorites,
    required TResult Function(String postId, String userUID)
        removeFromFavorites,
    required TResult Function(String userUID) refreshFavoritePosts,
    required TResult Function(String postId, String userUID) unstarPost,
    required TResult Function() clearFavorites,
  }) {
    return refreshFavoritePosts(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadFavoritePosts,
    TResult? Function(String postId, String userUID)? addToFavorites,
    TResult? Function(String postId, String userUID)? removeFromFavorites,
    TResult? Function(String userUID)? refreshFavoritePosts,
    TResult? Function(String postId, String userUID)? unstarPost,
    TResult? Function()? clearFavorites,
  }) {
    return refreshFavoritePosts?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadFavoritePosts,
    TResult Function(String postId, String userUID)? addToFavorites,
    TResult Function(String postId, String userUID)? removeFromFavorites,
    TResult Function(String userUID)? refreshFavoritePosts,
    TResult Function(String postId, String userUID)? unstarPost,
    TResult Function()? clearFavorites,
    required TResult orElse(),
  }) {
    if (refreshFavoritePosts != null) {
      return refreshFavoritePosts(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavoritePosts value) loadFavoritePosts,
    required TResult Function(AddToFavorites value) addToFavorites,
    required TResult Function(RemoveFromFavorites value) removeFromFavorites,
    required TResult Function(RefreshFavoritePosts value) refreshFavoritePosts,
    required TResult Function(UnstarPost value) unstarPost,
    required TResult Function(ClearFavorites value) clearFavorites,
  }) {
    return refreshFavoritePosts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult? Function(AddToFavorites value)? addToFavorites,
    TResult? Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult? Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult? Function(UnstarPost value)? unstarPost,
    TResult? Function(ClearFavorites value)? clearFavorites,
  }) {
    return refreshFavoritePosts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult Function(AddToFavorites value)? addToFavorites,
    TResult Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult Function(UnstarPost value)? unstarPost,
    TResult Function(ClearFavorites value)? clearFavorites,
    required TResult orElse(),
  }) {
    if (refreshFavoritePosts != null) {
      return refreshFavoritePosts(this);
    }
    return orElse();
  }
}

abstract class RefreshFavoritePosts implements FavoritesEvent {
  const factory RefreshFavoritePosts(final String userUID) =
      _$RefreshFavoritePostsImpl;

  String get userUID;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshFavoritePostsImplCopyWith<_$RefreshFavoritePostsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnstarPostImplCopyWith<$Res> {
  factory _$$UnstarPostImplCopyWith(
          _$UnstarPostImpl value, $Res Function(_$UnstarPostImpl) then) =
      __$$UnstarPostImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, String userUID});
}

/// @nodoc
class __$$UnstarPostImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$UnstarPostImpl>
    implements _$$UnstarPostImplCopyWith<$Res> {
  __$$UnstarPostImplCopyWithImpl(
      _$UnstarPostImpl _value, $Res Function(_$UnstarPostImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userUID = null,
  }) {
    return _then(_$UnstarPostImpl(
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

class _$UnstarPostImpl implements UnstarPost {
  const _$UnstarPostImpl({required this.postId, required this.userUID});

  @override
  final String postId;
  @override
  final String userUID;

  @override
  String toString() {
    return 'FavoritesEvent.unstarPost(postId: $postId, userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnstarPostImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, userUID);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnstarPostImplCopyWith<_$UnstarPostImpl> get copyWith =>
      __$$UnstarPostImplCopyWithImpl<_$UnstarPostImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadFavoritePosts,
    required TResult Function(String postId, String userUID) addToFavorites,
    required TResult Function(String postId, String userUID)
        removeFromFavorites,
    required TResult Function(String userUID) refreshFavoritePosts,
    required TResult Function(String postId, String userUID) unstarPost,
    required TResult Function() clearFavorites,
  }) {
    return unstarPost(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadFavoritePosts,
    TResult? Function(String postId, String userUID)? addToFavorites,
    TResult? Function(String postId, String userUID)? removeFromFavorites,
    TResult? Function(String userUID)? refreshFavoritePosts,
    TResult? Function(String postId, String userUID)? unstarPost,
    TResult? Function()? clearFavorites,
  }) {
    return unstarPost?.call(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadFavoritePosts,
    TResult Function(String postId, String userUID)? addToFavorites,
    TResult Function(String postId, String userUID)? removeFromFavorites,
    TResult Function(String userUID)? refreshFavoritePosts,
    TResult Function(String postId, String userUID)? unstarPost,
    TResult Function()? clearFavorites,
    required TResult orElse(),
  }) {
    if (unstarPost != null) {
      return unstarPost(postId, userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavoritePosts value) loadFavoritePosts,
    required TResult Function(AddToFavorites value) addToFavorites,
    required TResult Function(RemoveFromFavorites value) removeFromFavorites,
    required TResult Function(RefreshFavoritePosts value) refreshFavoritePosts,
    required TResult Function(UnstarPost value) unstarPost,
    required TResult Function(ClearFavorites value) clearFavorites,
  }) {
    return unstarPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult? Function(AddToFavorites value)? addToFavorites,
    TResult? Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult? Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult? Function(UnstarPost value)? unstarPost,
    TResult? Function(ClearFavorites value)? clearFavorites,
  }) {
    return unstarPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult Function(AddToFavorites value)? addToFavorites,
    TResult Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult Function(UnstarPost value)? unstarPost,
    TResult Function(ClearFavorites value)? clearFavorites,
    required TResult orElse(),
  }) {
    if (unstarPost != null) {
      return unstarPost(this);
    }
    return orElse();
  }
}

abstract class UnstarPost implements FavoritesEvent {
  const factory UnstarPost(
      {required final String postId,
      required final String userUID}) = _$UnstarPostImpl;

  String get postId;
  String get userUID;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnstarPostImplCopyWith<_$UnstarPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearFavoritesImplCopyWith<$Res> {
  factory _$$ClearFavoritesImplCopyWith(_$ClearFavoritesImpl value,
          $Res Function(_$ClearFavoritesImpl) then) =
      __$$ClearFavoritesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearFavoritesImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$ClearFavoritesImpl>
    implements _$$ClearFavoritesImplCopyWith<$Res> {
  __$$ClearFavoritesImplCopyWithImpl(
      _$ClearFavoritesImpl _value, $Res Function(_$ClearFavoritesImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearFavoritesImpl implements ClearFavorites {
  const _$ClearFavoritesImpl();

  @override
  String toString() {
    return 'FavoritesEvent.clearFavorites()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearFavoritesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadFavoritePosts,
    required TResult Function(String postId, String userUID) addToFavorites,
    required TResult Function(String postId, String userUID)
        removeFromFavorites,
    required TResult Function(String userUID) refreshFavoritePosts,
    required TResult Function(String postId, String userUID) unstarPost,
    required TResult Function() clearFavorites,
  }) {
    return clearFavorites();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadFavoritePosts,
    TResult? Function(String postId, String userUID)? addToFavorites,
    TResult? Function(String postId, String userUID)? removeFromFavorites,
    TResult? Function(String userUID)? refreshFavoritePosts,
    TResult? Function(String postId, String userUID)? unstarPost,
    TResult? Function()? clearFavorites,
  }) {
    return clearFavorites?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadFavoritePosts,
    TResult Function(String postId, String userUID)? addToFavorites,
    TResult Function(String postId, String userUID)? removeFromFavorites,
    TResult Function(String userUID)? refreshFavoritePosts,
    TResult Function(String postId, String userUID)? unstarPost,
    TResult Function()? clearFavorites,
    required TResult orElse(),
  }) {
    if (clearFavorites != null) {
      return clearFavorites();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadFavoritePosts value) loadFavoritePosts,
    required TResult Function(AddToFavorites value) addToFavorites,
    required TResult Function(RemoveFromFavorites value) removeFromFavorites,
    required TResult Function(RefreshFavoritePosts value) refreshFavoritePosts,
    required TResult Function(UnstarPost value) unstarPost,
    required TResult Function(ClearFavorites value) clearFavorites,
  }) {
    return clearFavorites(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult? Function(AddToFavorites value)? addToFavorites,
    TResult? Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult? Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult? Function(UnstarPost value)? unstarPost,
    TResult? Function(ClearFavorites value)? clearFavorites,
  }) {
    return clearFavorites?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadFavoritePosts value)? loadFavoritePosts,
    TResult Function(AddToFavorites value)? addToFavorites,
    TResult Function(RemoveFromFavorites value)? removeFromFavorites,
    TResult Function(RefreshFavoritePosts value)? refreshFavoritePosts,
    TResult Function(UnstarPost value)? unstarPost,
    TResult Function(ClearFavorites value)? clearFavorites,
    required TResult orElse(),
  }) {
    if (clearFavorites != null) {
      return clearFavorites(this);
    }
    return orElse();
  }
}

abstract class ClearFavorites implements FavoritesEvent {
  const factory ClearFavorites() = _$ClearFavoritesImpl;
}
