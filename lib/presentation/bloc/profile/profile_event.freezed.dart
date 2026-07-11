// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String targetUserUID, String viewerUserUID)
        loadUserProfile,
    required TResult Function(String postId, String userUID) likePostInProfile,
    required TResult Function(Post post) addOrUpdatePostInProfile,
    required TResult Function(String currentUserUID, String targetUserUID)
        blockUser,
    required TResult Function(String currentUserUID, String targetUserUID)
        unblockUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult? Function(String postId, String userUID)? likePostInProfile,
    TResult? Function(Post post)? addOrUpdatePostInProfile,
    TResult? Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult? Function(String currentUserUID, String targetUserUID)? unblockUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult Function(String postId, String userUID)? likePostInProfile,
    TResult Function(Post post)? addOrUpdatePostInProfile,
    TResult Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult Function(String currentUserUID, String targetUserUID)? unblockUser,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadUserProfile value) loadUserProfile,
    required TResult Function(LikePostInProfile value) likePostInProfile,
    required TResult Function(AddOrUpdatePostInProfile value)
        addOrUpdatePostInProfile,
    required TResult Function(BlockUser value) blockUser,
    required TResult Function(UnblockUser value) unblockUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadUserProfile value)? loadUserProfile,
    TResult? Function(LikePostInProfile value)? likePostInProfile,
    TResult? Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult? Function(BlockUser value)? blockUser,
    TResult? Function(UnblockUser value)? unblockUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadUserProfile value)? loadUserProfile,
    TResult Function(LikePostInProfile value)? likePostInProfile,
    TResult Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult Function(BlockUser value)? blockUser,
    TResult Function(UnblockUser value)? unblockUser,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEventCopyWith<$Res> {
  factory $ProfileEventCopyWith(
          ProfileEvent value, $Res Function(ProfileEvent) then) =
      _$ProfileEventCopyWithImpl<$Res, ProfileEvent>;
}

/// @nodoc
class _$ProfileEventCopyWithImpl<$Res, $Val extends ProfileEvent>
    implements $ProfileEventCopyWith<$Res> {
  _$ProfileEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadUserProfileImplCopyWith<$Res> {
  factory _$$LoadUserProfileImplCopyWith(_$LoadUserProfileImpl value,
          $Res Function(_$LoadUserProfileImpl) then) =
      __$$LoadUserProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String targetUserUID, String viewerUserUID});
}

/// @nodoc
class __$$LoadUserProfileImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$LoadUserProfileImpl>
    implements _$$LoadUserProfileImplCopyWith<$Res> {
  __$$LoadUserProfileImplCopyWithImpl(
      _$LoadUserProfileImpl _value, $Res Function(_$LoadUserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetUserUID = null,
    Object? viewerUserUID = null,
  }) {
    return _then(_$LoadUserProfileImpl(
      targetUserUID: null == targetUserUID
          ? _value.targetUserUID
          : targetUserUID // ignore: cast_nullable_to_non_nullable
              as String,
      viewerUserUID: null == viewerUserUID
          ? _value.viewerUserUID
          : viewerUserUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadUserProfileImpl implements LoadUserProfile {
  const _$LoadUserProfileImpl(
      {required this.targetUserUID, required this.viewerUserUID});

  @override
  final String targetUserUID;
  @override
  final String viewerUserUID;

  @override
  String toString() {
    return 'ProfileEvent.loadUserProfile(targetUserUID: $targetUserUID, viewerUserUID: $viewerUserUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadUserProfileImpl &&
            (identical(other.targetUserUID, targetUserUID) ||
                other.targetUserUID == targetUserUID) &&
            (identical(other.viewerUserUID, viewerUserUID) ||
                other.viewerUserUID == viewerUserUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, targetUserUID, viewerUserUID);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadUserProfileImplCopyWith<_$LoadUserProfileImpl> get copyWith =>
      __$$LoadUserProfileImplCopyWithImpl<_$LoadUserProfileImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String targetUserUID, String viewerUserUID)
        loadUserProfile,
    required TResult Function(String postId, String userUID) likePostInProfile,
    required TResult Function(Post post) addOrUpdatePostInProfile,
    required TResult Function(String currentUserUID, String targetUserUID)
        blockUser,
    required TResult Function(String currentUserUID, String targetUserUID)
        unblockUser,
  }) {
    return loadUserProfile(targetUserUID, viewerUserUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult? Function(String postId, String userUID)? likePostInProfile,
    TResult? Function(Post post)? addOrUpdatePostInProfile,
    TResult? Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult? Function(String currentUserUID, String targetUserUID)? unblockUser,
  }) {
    return loadUserProfile?.call(targetUserUID, viewerUserUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult Function(String postId, String userUID)? likePostInProfile,
    TResult Function(Post post)? addOrUpdatePostInProfile,
    TResult Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult Function(String currentUserUID, String targetUserUID)? unblockUser,
    required TResult orElse(),
  }) {
    if (loadUserProfile != null) {
      return loadUserProfile(targetUserUID, viewerUserUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadUserProfile value) loadUserProfile,
    required TResult Function(LikePostInProfile value) likePostInProfile,
    required TResult Function(AddOrUpdatePostInProfile value)
        addOrUpdatePostInProfile,
    required TResult Function(BlockUser value) blockUser,
    required TResult Function(UnblockUser value) unblockUser,
  }) {
    return loadUserProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadUserProfile value)? loadUserProfile,
    TResult? Function(LikePostInProfile value)? likePostInProfile,
    TResult? Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult? Function(BlockUser value)? blockUser,
    TResult? Function(UnblockUser value)? unblockUser,
  }) {
    return loadUserProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadUserProfile value)? loadUserProfile,
    TResult Function(LikePostInProfile value)? likePostInProfile,
    TResult Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult Function(BlockUser value)? blockUser,
    TResult Function(UnblockUser value)? unblockUser,
    required TResult orElse(),
  }) {
    if (loadUserProfile != null) {
      return loadUserProfile(this);
    }
    return orElse();
  }
}

abstract class LoadUserProfile implements ProfileEvent {
  const factory LoadUserProfile(
      {required final String targetUserUID,
      required final String viewerUserUID}) = _$LoadUserProfileImpl;

  String get targetUserUID;
  String get viewerUserUID;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadUserProfileImplCopyWith<_$LoadUserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LikePostInProfileImplCopyWith<$Res> {
  factory _$$LikePostInProfileImplCopyWith(_$LikePostInProfileImpl value,
          $Res Function(_$LikePostInProfileImpl) then) =
      __$$LikePostInProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, String userUID});
}

/// @nodoc
class __$$LikePostInProfileImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$LikePostInProfileImpl>
    implements _$$LikePostInProfileImplCopyWith<$Res> {
  __$$LikePostInProfileImplCopyWithImpl(_$LikePostInProfileImpl _value,
      $Res Function(_$LikePostInProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userUID = null,
  }) {
    return _then(_$LikePostInProfileImpl(
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

class _$LikePostInProfileImpl implements LikePostInProfile {
  const _$LikePostInProfileImpl({required this.postId, required this.userUID});

  @override
  final String postId;
  @override
  final String userUID;

  @override
  String toString() {
    return 'ProfileEvent.likePostInProfile(postId: $postId, userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikePostInProfileImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, userUID);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LikePostInProfileImplCopyWith<_$LikePostInProfileImpl> get copyWith =>
      __$$LikePostInProfileImplCopyWithImpl<_$LikePostInProfileImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String targetUserUID, String viewerUserUID)
        loadUserProfile,
    required TResult Function(String postId, String userUID) likePostInProfile,
    required TResult Function(Post post) addOrUpdatePostInProfile,
    required TResult Function(String currentUserUID, String targetUserUID)
        blockUser,
    required TResult Function(String currentUserUID, String targetUserUID)
        unblockUser,
  }) {
    return likePostInProfile(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult? Function(String postId, String userUID)? likePostInProfile,
    TResult? Function(Post post)? addOrUpdatePostInProfile,
    TResult? Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult? Function(String currentUserUID, String targetUserUID)? unblockUser,
  }) {
    return likePostInProfile?.call(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult Function(String postId, String userUID)? likePostInProfile,
    TResult Function(Post post)? addOrUpdatePostInProfile,
    TResult Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult Function(String currentUserUID, String targetUserUID)? unblockUser,
    required TResult orElse(),
  }) {
    if (likePostInProfile != null) {
      return likePostInProfile(postId, userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadUserProfile value) loadUserProfile,
    required TResult Function(LikePostInProfile value) likePostInProfile,
    required TResult Function(AddOrUpdatePostInProfile value)
        addOrUpdatePostInProfile,
    required TResult Function(BlockUser value) blockUser,
    required TResult Function(UnblockUser value) unblockUser,
  }) {
    return likePostInProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadUserProfile value)? loadUserProfile,
    TResult? Function(LikePostInProfile value)? likePostInProfile,
    TResult? Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult? Function(BlockUser value)? blockUser,
    TResult? Function(UnblockUser value)? unblockUser,
  }) {
    return likePostInProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadUserProfile value)? loadUserProfile,
    TResult Function(LikePostInProfile value)? likePostInProfile,
    TResult Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult Function(BlockUser value)? blockUser,
    TResult Function(UnblockUser value)? unblockUser,
    required TResult orElse(),
  }) {
    if (likePostInProfile != null) {
      return likePostInProfile(this);
    }
    return orElse();
  }
}

abstract class LikePostInProfile implements ProfileEvent {
  const factory LikePostInProfile(
      {required final String postId,
      required final String userUID}) = _$LikePostInProfileImpl;

  String get postId;
  String get userUID;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LikePostInProfileImplCopyWith<_$LikePostInProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddOrUpdatePostInProfileImplCopyWith<$Res> {
  factory _$$AddOrUpdatePostInProfileImplCopyWith(
          _$AddOrUpdatePostInProfileImpl value,
          $Res Function(_$AddOrUpdatePostInProfileImpl) then) =
      __$$AddOrUpdatePostInProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Post post});
}

/// @nodoc
class __$$AddOrUpdatePostInProfileImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$AddOrUpdatePostInProfileImpl>
    implements _$$AddOrUpdatePostInProfileImplCopyWith<$Res> {
  __$$AddOrUpdatePostInProfileImplCopyWithImpl(
      _$AddOrUpdatePostInProfileImpl _value,
      $Res Function(_$AddOrUpdatePostInProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
  }) {
    return _then(_$AddOrUpdatePostInProfileImpl(
      null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }
}

/// @nodoc

class _$AddOrUpdatePostInProfileImpl implements AddOrUpdatePostInProfile {
  const _$AddOrUpdatePostInProfileImpl(this.post);

  @override
  final Post post;

  @override
  String toString() {
    return 'ProfileEvent.addOrUpdatePostInProfile(post: $post)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddOrUpdatePostInProfileImpl &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddOrUpdatePostInProfileImplCopyWith<_$AddOrUpdatePostInProfileImpl>
      get copyWith => __$$AddOrUpdatePostInProfileImplCopyWithImpl<
          _$AddOrUpdatePostInProfileImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String targetUserUID, String viewerUserUID)
        loadUserProfile,
    required TResult Function(String postId, String userUID) likePostInProfile,
    required TResult Function(Post post) addOrUpdatePostInProfile,
    required TResult Function(String currentUserUID, String targetUserUID)
        blockUser,
    required TResult Function(String currentUserUID, String targetUserUID)
        unblockUser,
  }) {
    return addOrUpdatePostInProfile(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult? Function(String postId, String userUID)? likePostInProfile,
    TResult? Function(Post post)? addOrUpdatePostInProfile,
    TResult? Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult? Function(String currentUserUID, String targetUserUID)? unblockUser,
  }) {
    return addOrUpdatePostInProfile?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult Function(String postId, String userUID)? likePostInProfile,
    TResult Function(Post post)? addOrUpdatePostInProfile,
    TResult Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult Function(String currentUserUID, String targetUserUID)? unblockUser,
    required TResult orElse(),
  }) {
    if (addOrUpdatePostInProfile != null) {
      return addOrUpdatePostInProfile(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadUserProfile value) loadUserProfile,
    required TResult Function(LikePostInProfile value) likePostInProfile,
    required TResult Function(AddOrUpdatePostInProfile value)
        addOrUpdatePostInProfile,
    required TResult Function(BlockUser value) blockUser,
    required TResult Function(UnblockUser value) unblockUser,
  }) {
    return addOrUpdatePostInProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadUserProfile value)? loadUserProfile,
    TResult? Function(LikePostInProfile value)? likePostInProfile,
    TResult? Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult? Function(BlockUser value)? blockUser,
    TResult? Function(UnblockUser value)? unblockUser,
  }) {
    return addOrUpdatePostInProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadUserProfile value)? loadUserProfile,
    TResult Function(LikePostInProfile value)? likePostInProfile,
    TResult Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult Function(BlockUser value)? blockUser,
    TResult Function(UnblockUser value)? unblockUser,
    required TResult orElse(),
  }) {
    if (addOrUpdatePostInProfile != null) {
      return addOrUpdatePostInProfile(this);
    }
    return orElse();
  }
}

abstract class AddOrUpdatePostInProfile implements ProfileEvent {
  const factory AddOrUpdatePostInProfile(final Post post) =
      _$AddOrUpdatePostInProfileImpl;

  Post get post;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddOrUpdatePostInProfileImplCopyWith<_$AddOrUpdatePostInProfileImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BlockUserImplCopyWith<$Res> {
  factory _$$BlockUserImplCopyWith(
          _$BlockUserImpl value, $Res Function(_$BlockUserImpl) then) =
      __$$BlockUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String currentUserUID, String targetUserUID});
}

/// @nodoc
class __$$BlockUserImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$BlockUserImpl>
    implements _$$BlockUserImplCopyWith<$Res> {
  __$$BlockUserImplCopyWithImpl(
      _$BlockUserImpl _value, $Res Function(_$BlockUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUserUID = null,
    Object? targetUserUID = null,
  }) {
    return _then(_$BlockUserImpl(
      currentUserUID: null == currentUserUID
          ? _value.currentUserUID
          : currentUserUID // ignore: cast_nullable_to_non_nullable
              as String,
      targetUserUID: null == targetUserUID
          ? _value.targetUserUID
          : targetUserUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BlockUserImpl implements BlockUser {
  const _$BlockUserImpl(
      {required this.currentUserUID, required this.targetUserUID});

  @override
  final String currentUserUID;
  @override
  final String targetUserUID;

  @override
  String toString() {
    return 'ProfileEvent.blockUser(currentUserUID: $currentUserUID, targetUserUID: $targetUserUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockUserImpl &&
            (identical(other.currentUserUID, currentUserUID) ||
                other.currentUserUID == currentUserUID) &&
            (identical(other.targetUserUID, targetUserUID) ||
                other.targetUserUID == targetUserUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentUserUID, targetUserUID);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockUserImplCopyWith<_$BlockUserImpl> get copyWith =>
      __$$BlockUserImplCopyWithImpl<_$BlockUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String targetUserUID, String viewerUserUID)
        loadUserProfile,
    required TResult Function(String postId, String userUID) likePostInProfile,
    required TResult Function(Post post) addOrUpdatePostInProfile,
    required TResult Function(String currentUserUID, String targetUserUID)
        blockUser,
    required TResult Function(String currentUserUID, String targetUserUID)
        unblockUser,
  }) {
    return blockUser(currentUserUID, targetUserUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult? Function(String postId, String userUID)? likePostInProfile,
    TResult? Function(Post post)? addOrUpdatePostInProfile,
    TResult? Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult? Function(String currentUserUID, String targetUserUID)? unblockUser,
  }) {
    return blockUser?.call(currentUserUID, targetUserUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult Function(String postId, String userUID)? likePostInProfile,
    TResult Function(Post post)? addOrUpdatePostInProfile,
    TResult Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult Function(String currentUserUID, String targetUserUID)? unblockUser,
    required TResult orElse(),
  }) {
    if (blockUser != null) {
      return blockUser(currentUserUID, targetUserUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadUserProfile value) loadUserProfile,
    required TResult Function(LikePostInProfile value) likePostInProfile,
    required TResult Function(AddOrUpdatePostInProfile value)
        addOrUpdatePostInProfile,
    required TResult Function(BlockUser value) blockUser,
    required TResult Function(UnblockUser value) unblockUser,
  }) {
    return blockUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadUserProfile value)? loadUserProfile,
    TResult? Function(LikePostInProfile value)? likePostInProfile,
    TResult? Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult? Function(BlockUser value)? blockUser,
    TResult? Function(UnblockUser value)? unblockUser,
  }) {
    return blockUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadUserProfile value)? loadUserProfile,
    TResult Function(LikePostInProfile value)? likePostInProfile,
    TResult Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult Function(BlockUser value)? blockUser,
    TResult Function(UnblockUser value)? unblockUser,
    required TResult orElse(),
  }) {
    if (blockUser != null) {
      return blockUser(this);
    }
    return orElse();
  }
}

abstract class BlockUser implements ProfileEvent {
  const factory BlockUser(
      {required final String currentUserUID,
      required final String targetUserUID}) = _$BlockUserImpl;

  String get currentUserUID;
  String get targetUserUID;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlockUserImplCopyWith<_$BlockUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnblockUserImplCopyWith<$Res> {
  factory _$$UnblockUserImplCopyWith(
          _$UnblockUserImpl value, $Res Function(_$UnblockUserImpl) then) =
      __$$UnblockUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String currentUserUID, String targetUserUID});
}

/// @nodoc
class __$$UnblockUserImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$UnblockUserImpl>
    implements _$$UnblockUserImplCopyWith<$Res> {
  __$$UnblockUserImplCopyWithImpl(
      _$UnblockUserImpl _value, $Res Function(_$UnblockUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUserUID = null,
    Object? targetUserUID = null,
  }) {
    return _then(_$UnblockUserImpl(
      currentUserUID: null == currentUserUID
          ? _value.currentUserUID
          : currentUserUID // ignore: cast_nullable_to_non_nullable
              as String,
      targetUserUID: null == targetUserUID
          ? _value.targetUserUID
          : targetUserUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnblockUserImpl implements UnblockUser {
  const _$UnblockUserImpl(
      {required this.currentUserUID, required this.targetUserUID});

  @override
  final String currentUserUID;
  @override
  final String targetUserUID;

  @override
  String toString() {
    return 'ProfileEvent.unblockUser(currentUserUID: $currentUserUID, targetUserUID: $targetUserUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnblockUserImpl &&
            (identical(other.currentUserUID, currentUserUID) ||
                other.currentUserUID == currentUserUID) &&
            (identical(other.targetUserUID, targetUserUID) ||
                other.targetUserUID == targetUserUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentUserUID, targetUserUID);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnblockUserImplCopyWith<_$UnblockUserImpl> get copyWith =>
      __$$UnblockUserImplCopyWithImpl<_$UnblockUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String targetUserUID, String viewerUserUID)
        loadUserProfile,
    required TResult Function(String postId, String userUID) likePostInProfile,
    required TResult Function(Post post) addOrUpdatePostInProfile,
    required TResult Function(String currentUserUID, String targetUserUID)
        blockUser,
    required TResult Function(String currentUserUID, String targetUserUID)
        unblockUser,
  }) {
    return unblockUser(currentUserUID, targetUserUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult? Function(String postId, String userUID)? likePostInProfile,
    TResult? Function(Post post)? addOrUpdatePostInProfile,
    TResult? Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult? Function(String currentUserUID, String targetUserUID)? unblockUser,
  }) {
    return unblockUser?.call(currentUserUID, targetUserUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String targetUserUID, String viewerUserUID)?
        loadUserProfile,
    TResult Function(String postId, String userUID)? likePostInProfile,
    TResult Function(Post post)? addOrUpdatePostInProfile,
    TResult Function(String currentUserUID, String targetUserUID)? blockUser,
    TResult Function(String currentUserUID, String targetUserUID)? unblockUser,
    required TResult orElse(),
  }) {
    if (unblockUser != null) {
      return unblockUser(currentUserUID, targetUserUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadUserProfile value) loadUserProfile,
    required TResult Function(LikePostInProfile value) likePostInProfile,
    required TResult Function(AddOrUpdatePostInProfile value)
        addOrUpdatePostInProfile,
    required TResult Function(BlockUser value) blockUser,
    required TResult Function(UnblockUser value) unblockUser,
  }) {
    return unblockUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadUserProfile value)? loadUserProfile,
    TResult? Function(LikePostInProfile value)? likePostInProfile,
    TResult? Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult? Function(BlockUser value)? blockUser,
    TResult? Function(UnblockUser value)? unblockUser,
  }) {
    return unblockUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadUserProfile value)? loadUserProfile,
    TResult Function(LikePostInProfile value)? likePostInProfile,
    TResult Function(AddOrUpdatePostInProfile value)? addOrUpdatePostInProfile,
    TResult Function(BlockUser value)? blockUser,
    TResult Function(UnblockUser value)? unblockUser,
    required TResult orElse(),
  }) {
    if (unblockUser != null) {
      return unblockUser(this);
    }
    return orElse();
  }
}

abstract class UnblockUser implements ProfileEvent {
  const factory UnblockUser(
      {required final String currentUserUID,
      required final String targetUserUID}) = _$UnblockUserImpl;

  String get currentUserUID;
  String get targetUserUID;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnblockUserImplCopyWith<_$UnblockUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
