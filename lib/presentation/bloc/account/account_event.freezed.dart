// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadAccountData,
    required TResult Function(
            UserPreference preferences, bool markOnboardingComplete)
        updateUserPreferences,
    required TResult Function(
            String userName, String userBio, String userBioLink)
        updateUserProfile,
    required TResult Function(String userUID) checkOnboardingStatus,
    required TResult Function(String postId, String userUID) likePostInAccount,
    required TResult Function(Post post) addOrUpdatePostInAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadAccountData,
    TResult? Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult? Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult? Function(String userUID)? checkOnboardingStatus,
    TResult? Function(String postId, String userUID)? likePostInAccount,
    TResult? Function(Post post)? addOrUpdatePostInAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadAccountData,
    TResult Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult Function(String userUID)? checkOnboardingStatus,
    TResult Function(String postId, String userUID)? likePostInAccount,
    TResult Function(Post post)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAccountData value) loadAccountData,
    required TResult Function(UpdateUserPreferences value)
        updateUserPreferences,
    required TResult Function(UpdateUserProfile value) updateUserProfile,
    required TResult Function(CheckOnboardingStatus value)
        checkOnboardingStatus,
    required TResult Function(LikePostInAccount value) likePostInAccount,
    required TResult Function(AddOrUpdatePostInAccount value)
        addOrUpdatePostInAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAccountData value)? loadAccountData,
    TResult? Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult? Function(UpdateUserProfile value)? updateUserProfile,
    TResult? Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult? Function(LikePostInAccount value)? likePostInAccount,
    TResult? Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAccountData value)? loadAccountData,
    TResult Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult Function(UpdateUserProfile value)? updateUserProfile,
    TResult Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult Function(LikePostInAccount value)? likePostInAccount,
    TResult Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountEventCopyWith<$Res> {
  factory $AccountEventCopyWith(
          AccountEvent value, $Res Function(AccountEvent) then) =
      _$AccountEventCopyWithImpl<$Res, AccountEvent>;
}

/// @nodoc
class _$AccountEventCopyWithImpl<$Res, $Val extends AccountEvent>
    implements $AccountEventCopyWith<$Res> {
  _$AccountEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadAccountDataImplCopyWith<$Res> {
  factory _$$LoadAccountDataImplCopyWith(_$LoadAccountDataImpl value,
          $Res Function(_$LoadAccountDataImpl) then) =
      __$$LoadAccountDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userUID});
}

/// @nodoc
class __$$LoadAccountDataImplCopyWithImpl<$Res>
    extends _$AccountEventCopyWithImpl<$Res, _$LoadAccountDataImpl>
    implements _$$LoadAccountDataImplCopyWith<$Res> {
  __$$LoadAccountDataImplCopyWithImpl(
      _$LoadAccountDataImpl _value, $Res Function(_$LoadAccountDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = null,
  }) {
    return _then(_$LoadAccountDataImpl(
      null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadAccountDataImpl implements LoadAccountData {
  const _$LoadAccountDataImpl(this.userUID);

  @override
  final String userUID;

  @override
  String toString() {
    return 'AccountEvent.loadAccountData(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadAccountDataImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadAccountDataImplCopyWith<_$LoadAccountDataImpl> get copyWith =>
      __$$LoadAccountDataImplCopyWithImpl<_$LoadAccountDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadAccountData,
    required TResult Function(
            UserPreference preferences, bool markOnboardingComplete)
        updateUserPreferences,
    required TResult Function(
            String userName, String userBio, String userBioLink)
        updateUserProfile,
    required TResult Function(String userUID) checkOnboardingStatus,
    required TResult Function(String postId, String userUID) likePostInAccount,
    required TResult Function(Post post) addOrUpdatePostInAccount,
  }) {
    return loadAccountData(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadAccountData,
    TResult? Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult? Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult? Function(String userUID)? checkOnboardingStatus,
    TResult? Function(String postId, String userUID)? likePostInAccount,
    TResult? Function(Post post)? addOrUpdatePostInAccount,
  }) {
    return loadAccountData?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadAccountData,
    TResult Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult Function(String userUID)? checkOnboardingStatus,
    TResult Function(String postId, String userUID)? likePostInAccount,
    TResult Function(Post post)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (loadAccountData != null) {
      return loadAccountData(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAccountData value) loadAccountData,
    required TResult Function(UpdateUserPreferences value)
        updateUserPreferences,
    required TResult Function(UpdateUserProfile value) updateUserProfile,
    required TResult Function(CheckOnboardingStatus value)
        checkOnboardingStatus,
    required TResult Function(LikePostInAccount value) likePostInAccount,
    required TResult Function(AddOrUpdatePostInAccount value)
        addOrUpdatePostInAccount,
  }) {
    return loadAccountData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAccountData value)? loadAccountData,
    TResult? Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult? Function(UpdateUserProfile value)? updateUserProfile,
    TResult? Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult? Function(LikePostInAccount value)? likePostInAccount,
    TResult? Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
  }) {
    return loadAccountData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAccountData value)? loadAccountData,
    TResult Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult Function(UpdateUserProfile value)? updateUserProfile,
    TResult Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult Function(LikePostInAccount value)? likePostInAccount,
    TResult Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (loadAccountData != null) {
      return loadAccountData(this);
    }
    return orElse();
  }
}

abstract class LoadAccountData implements AccountEvent {
  const factory LoadAccountData(final String userUID) = _$LoadAccountDataImpl;

  String get userUID;

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadAccountDataImplCopyWith<_$LoadAccountDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateUserPreferencesImplCopyWith<$Res> {
  factory _$$UpdateUserPreferencesImplCopyWith(
          _$UpdateUserPreferencesImpl value,
          $Res Function(_$UpdateUserPreferencesImpl) then) =
      __$$UpdateUserPreferencesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserPreference preferences, bool markOnboardingComplete});
}

/// @nodoc
class __$$UpdateUserPreferencesImplCopyWithImpl<$Res>
    extends _$AccountEventCopyWithImpl<$Res, _$UpdateUserPreferencesImpl>
    implements _$$UpdateUserPreferencesImplCopyWith<$Res> {
  __$$UpdateUserPreferencesImplCopyWithImpl(_$UpdateUserPreferencesImpl _value,
      $Res Function(_$UpdateUserPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferences = null,
    Object? markOnboardingComplete = null,
  }) {
    return _then(_$UpdateUserPreferencesImpl(
      null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreference,
      markOnboardingComplete: null == markOnboardingComplete
          ? _value.markOnboardingComplete
          : markOnboardingComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UpdateUserPreferencesImpl implements UpdateUserPreferences {
  const _$UpdateUserPreferencesImpl(this.preferences,
      {this.markOnboardingComplete = false});

  @override
  final UserPreference preferences;
  @override
  @JsonKey()
  final bool markOnboardingComplete;

  @override
  String toString() {
    return 'AccountEvent.updateUserPreferences(preferences: $preferences, markOnboardingComplete: $markOnboardingComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateUserPreferencesImpl &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            (identical(other.markOnboardingComplete, markOnboardingComplete) ||
                other.markOnboardingComplete == markOnboardingComplete));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, preferences, markOnboardingComplete);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateUserPreferencesImplCopyWith<_$UpdateUserPreferencesImpl>
      get copyWith => __$$UpdateUserPreferencesImplCopyWithImpl<
          _$UpdateUserPreferencesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadAccountData,
    required TResult Function(
            UserPreference preferences, bool markOnboardingComplete)
        updateUserPreferences,
    required TResult Function(
            String userName, String userBio, String userBioLink)
        updateUserProfile,
    required TResult Function(String userUID) checkOnboardingStatus,
    required TResult Function(String postId, String userUID) likePostInAccount,
    required TResult Function(Post post) addOrUpdatePostInAccount,
  }) {
    return updateUserPreferences(preferences, markOnboardingComplete);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadAccountData,
    TResult? Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult? Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult? Function(String userUID)? checkOnboardingStatus,
    TResult? Function(String postId, String userUID)? likePostInAccount,
    TResult? Function(Post post)? addOrUpdatePostInAccount,
  }) {
    return updateUserPreferences?.call(preferences, markOnboardingComplete);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadAccountData,
    TResult Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult Function(String userUID)? checkOnboardingStatus,
    TResult Function(String postId, String userUID)? likePostInAccount,
    TResult Function(Post post)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (updateUserPreferences != null) {
      return updateUserPreferences(preferences, markOnboardingComplete);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAccountData value) loadAccountData,
    required TResult Function(UpdateUserPreferences value)
        updateUserPreferences,
    required TResult Function(UpdateUserProfile value) updateUserProfile,
    required TResult Function(CheckOnboardingStatus value)
        checkOnboardingStatus,
    required TResult Function(LikePostInAccount value) likePostInAccount,
    required TResult Function(AddOrUpdatePostInAccount value)
        addOrUpdatePostInAccount,
  }) {
    return updateUserPreferences(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAccountData value)? loadAccountData,
    TResult? Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult? Function(UpdateUserProfile value)? updateUserProfile,
    TResult? Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult? Function(LikePostInAccount value)? likePostInAccount,
    TResult? Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
  }) {
    return updateUserPreferences?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAccountData value)? loadAccountData,
    TResult Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult Function(UpdateUserProfile value)? updateUserProfile,
    TResult Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult Function(LikePostInAccount value)? likePostInAccount,
    TResult Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (updateUserPreferences != null) {
      return updateUserPreferences(this);
    }
    return orElse();
  }
}

abstract class UpdateUserPreferences implements AccountEvent {
  const factory UpdateUserPreferences(final UserPreference preferences,
      {final bool markOnboardingComplete}) = _$UpdateUserPreferencesImpl;

  UserPreference get preferences;
  bool get markOnboardingComplete;

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateUserPreferencesImplCopyWith<_$UpdateUserPreferencesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateUserProfileImplCopyWith<$Res> {
  factory _$$UpdateUserProfileImplCopyWith(_$UpdateUserProfileImpl value,
          $Res Function(_$UpdateUserProfileImpl) then) =
      __$$UpdateUserProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userName, String userBio, String userBioLink});
}

/// @nodoc
class __$$UpdateUserProfileImplCopyWithImpl<$Res>
    extends _$AccountEventCopyWithImpl<$Res, _$UpdateUserProfileImpl>
    implements _$$UpdateUserProfileImplCopyWith<$Res> {
  __$$UpdateUserProfileImplCopyWithImpl(_$UpdateUserProfileImpl _value,
      $Res Function(_$UpdateUserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? userBio = null,
    Object? userBioLink = null,
  }) {
    return _then(_$UpdateUserProfileImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userBio: null == userBio
          ? _value.userBio
          : userBio // ignore: cast_nullable_to_non_nullable
              as String,
      userBioLink: null == userBioLink
          ? _value.userBioLink
          : userBioLink // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateUserProfileImpl implements UpdateUserProfile {
  const _$UpdateUserProfileImpl(
      {required this.userName,
      required this.userBio,
      required this.userBioLink});

  @override
  final String userName;
  @override
  final String userBio;
  @override
  final String userBioLink;

  @override
  String toString() {
    return 'AccountEvent.updateUserProfile(userName: $userName, userBio: $userBio, userBioLink: $userBioLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateUserProfileImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userBio, userBio) || other.userBio == userBio) &&
            (identical(other.userBioLink, userBioLink) ||
                other.userBioLink == userBioLink));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName, userBio, userBioLink);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateUserProfileImplCopyWith<_$UpdateUserProfileImpl> get copyWith =>
      __$$UpdateUserProfileImplCopyWithImpl<_$UpdateUserProfileImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadAccountData,
    required TResult Function(
            UserPreference preferences, bool markOnboardingComplete)
        updateUserPreferences,
    required TResult Function(
            String userName, String userBio, String userBioLink)
        updateUserProfile,
    required TResult Function(String userUID) checkOnboardingStatus,
    required TResult Function(String postId, String userUID) likePostInAccount,
    required TResult Function(Post post) addOrUpdatePostInAccount,
  }) {
    return updateUserProfile(userName, userBio, userBioLink);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadAccountData,
    TResult? Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult? Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult? Function(String userUID)? checkOnboardingStatus,
    TResult? Function(String postId, String userUID)? likePostInAccount,
    TResult? Function(Post post)? addOrUpdatePostInAccount,
  }) {
    return updateUserProfile?.call(userName, userBio, userBioLink);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadAccountData,
    TResult Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult Function(String userUID)? checkOnboardingStatus,
    TResult Function(String postId, String userUID)? likePostInAccount,
    TResult Function(Post post)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (updateUserProfile != null) {
      return updateUserProfile(userName, userBio, userBioLink);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAccountData value) loadAccountData,
    required TResult Function(UpdateUserPreferences value)
        updateUserPreferences,
    required TResult Function(UpdateUserProfile value) updateUserProfile,
    required TResult Function(CheckOnboardingStatus value)
        checkOnboardingStatus,
    required TResult Function(LikePostInAccount value) likePostInAccount,
    required TResult Function(AddOrUpdatePostInAccount value)
        addOrUpdatePostInAccount,
  }) {
    return updateUserProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAccountData value)? loadAccountData,
    TResult? Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult? Function(UpdateUserProfile value)? updateUserProfile,
    TResult? Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult? Function(LikePostInAccount value)? likePostInAccount,
    TResult? Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
  }) {
    return updateUserProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAccountData value)? loadAccountData,
    TResult Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult Function(UpdateUserProfile value)? updateUserProfile,
    TResult Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult Function(LikePostInAccount value)? likePostInAccount,
    TResult Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (updateUserProfile != null) {
      return updateUserProfile(this);
    }
    return orElse();
  }
}

abstract class UpdateUserProfile implements AccountEvent {
  const factory UpdateUserProfile(
      {required final String userName,
      required final String userBio,
      required final String userBioLink}) = _$UpdateUserProfileImpl;

  String get userName;
  String get userBio;
  String get userBioLink;

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateUserProfileImplCopyWith<_$UpdateUserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckOnboardingStatusImplCopyWith<$Res> {
  factory _$$CheckOnboardingStatusImplCopyWith(
          _$CheckOnboardingStatusImpl value,
          $Res Function(_$CheckOnboardingStatusImpl) then) =
      __$$CheckOnboardingStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userUID});
}

/// @nodoc
class __$$CheckOnboardingStatusImplCopyWithImpl<$Res>
    extends _$AccountEventCopyWithImpl<$Res, _$CheckOnboardingStatusImpl>
    implements _$$CheckOnboardingStatusImplCopyWith<$Res> {
  __$$CheckOnboardingStatusImplCopyWithImpl(_$CheckOnboardingStatusImpl _value,
      $Res Function(_$CheckOnboardingStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = null,
  }) {
    return _then(_$CheckOnboardingStatusImpl(
      null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CheckOnboardingStatusImpl implements CheckOnboardingStatus {
  const _$CheckOnboardingStatusImpl(this.userUID);

  @override
  final String userUID;

  @override
  String toString() {
    return 'AccountEvent.checkOnboardingStatus(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckOnboardingStatusImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckOnboardingStatusImplCopyWith<_$CheckOnboardingStatusImpl>
      get copyWith => __$$CheckOnboardingStatusImplCopyWithImpl<
          _$CheckOnboardingStatusImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadAccountData,
    required TResult Function(
            UserPreference preferences, bool markOnboardingComplete)
        updateUserPreferences,
    required TResult Function(
            String userName, String userBio, String userBioLink)
        updateUserProfile,
    required TResult Function(String userUID) checkOnboardingStatus,
    required TResult Function(String postId, String userUID) likePostInAccount,
    required TResult Function(Post post) addOrUpdatePostInAccount,
  }) {
    return checkOnboardingStatus(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadAccountData,
    TResult? Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult? Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult? Function(String userUID)? checkOnboardingStatus,
    TResult? Function(String postId, String userUID)? likePostInAccount,
    TResult? Function(Post post)? addOrUpdatePostInAccount,
  }) {
    return checkOnboardingStatus?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadAccountData,
    TResult Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult Function(String userUID)? checkOnboardingStatus,
    TResult Function(String postId, String userUID)? likePostInAccount,
    TResult Function(Post post)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (checkOnboardingStatus != null) {
      return checkOnboardingStatus(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAccountData value) loadAccountData,
    required TResult Function(UpdateUserPreferences value)
        updateUserPreferences,
    required TResult Function(UpdateUserProfile value) updateUserProfile,
    required TResult Function(CheckOnboardingStatus value)
        checkOnboardingStatus,
    required TResult Function(LikePostInAccount value) likePostInAccount,
    required TResult Function(AddOrUpdatePostInAccount value)
        addOrUpdatePostInAccount,
  }) {
    return checkOnboardingStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAccountData value)? loadAccountData,
    TResult? Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult? Function(UpdateUserProfile value)? updateUserProfile,
    TResult? Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult? Function(LikePostInAccount value)? likePostInAccount,
    TResult? Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
  }) {
    return checkOnboardingStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAccountData value)? loadAccountData,
    TResult Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult Function(UpdateUserProfile value)? updateUserProfile,
    TResult Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult Function(LikePostInAccount value)? likePostInAccount,
    TResult Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (checkOnboardingStatus != null) {
      return checkOnboardingStatus(this);
    }
    return orElse();
  }
}

abstract class CheckOnboardingStatus implements AccountEvent {
  const factory CheckOnboardingStatus(final String userUID) =
      _$CheckOnboardingStatusImpl;

  String get userUID;

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckOnboardingStatusImplCopyWith<_$CheckOnboardingStatusImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LikePostInAccountImplCopyWith<$Res> {
  factory _$$LikePostInAccountImplCopyWith(_$LikePostInAccountImpl value,
          $Res Function(_$LikePostInAccountImpl) then) =
      __$$LikePostInAccountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId, String userUID});
}

/// @nodoc
class __$$LikePostInAccountImplCopyWithImpl<$Res>
    extends _$AccountEventCopyWithImpl<$Res, _$LikePostInAccountImpl>
    implements _$$LikePostInAccountImplCopyWith<$Res> {
  __$$LikePostInAccountImplCopyWithImpl(_$LikePostInAccountImpl _value,
      $Res Function(_$LikePostInAccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userUID = null,
  }) {
    return _then(_$LikePostInAccountImpl(
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

class _$LikePostInAccountImpl implements LikePostInAccount {
  const _$LikePostInAccountImpl({required this.postId, required this.userUID});

  @override
  final String postId;
  @override
  final String userUID;

  @override
  String toString() {
    return 'AccountEvent.likePostInAccount(postId: $postId, userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikePostInAccountImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, userUID);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LikePostInAccountImplCopyWith<_$LikePostInAccountImpl> get copyWith =>
      __$$LikePostInAccountImplCopyWithImpl<_$LikePostInAccountImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadAccountData,
    required TResult Function(
            UserPreference preferences, bool markOnboardingComplete)
        updateUserPreferences,
    required TResult Function(
            String userName, String userBio, String userBioLink)
        updateUserProfile,
    required TResult Function(String userUID) checkOnboardingStatus,
    required TResult Function(String postId, String userUID) likePostInAccount,
    required TResult Function(Post post) addOrUpdatePostInAccount,
  }) {
    return likePostInAccount(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadAccountData,
    TResult? Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult? Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult? Function(String userUID)? checkOnboardingStatus,
    TResult? Function(String postId, String userUID)? likePostInAccount,
    TResult? Function(Post post)? addOrUpdatePostInAccount,
  }) {
    return likePostInAccount?.call(postId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadAccountData,
    TResult Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult Function(String userUID)? checkOnboardingStatus,
    TResult Function(String postId, String userUID)? likePostInAccount,
    TResult Function(Post post)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (likePostInAccount != null) {
      return likePostInAccount(postId, userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAccountData value) loadAccountData,
    required TResult Function(UpdateUserPreferences value)
        updateUserPreferences,
    required TResult Function(UpdateUserProfile value) updateUserProfile,
    required TResult Function(CheckOnboardingStatus value)
        checkOnboardingStatus,
    required TResult Function(LikePostInAccount value) likePostInAccount,
    required TResult Function(AddOrUpdatePostInAccount value)
        addOrUpdatePostInAccount,
  }) {
    return likePostInAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAccountData value)? loadAccountData,
    TResult? Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult? Function(UpdateUserProfile value)? updateUserProfile,
    TResult? Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult? Function(LikePostInAccount value)? likePostInAccount,
    TResult? Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
  }) {
    return likePostInAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAccountData value)? loadAccountData,
    TResult Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult Function(UpdateUserProfile value)? updateUserProfile,
    TResult Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult Function(LikePostInAccount value)? likePostInAccount,
    TResult Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (likePostInAccount != null) {
      return likePostInAccount(this);
    }
    return orElse();
  }
}

abstract class LikePostInAccount implements AccountEvent {
  const factory LikePostInAccount(
      {required final String postId,
      required final String userUID}) = _$LikePostInAccountImpl;

  String get postId;
  String get userUID;

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LikePostInAccountImplCopyWith<_$LikePostInAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddOrUpdatePostInAccountImplCopyWith<$Res> {
  factory _$$AddOrUpdatePostInAccountImplCopyWith(
          _$AddOrUpdatePostInAccountImpl value,
          $Res Function(_$AddOrUpdatePostInAccountImpl) then) =
      __$$AddOrUpdatePostInAccountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Post post});
}

/// @nodoc
class __$$AddOrUpdatePostInAccountImplCopyWithImpl<$Res>
    extends _$AccountEventCopyWithImpl<$Res, _$AddOrUpdatePostInAccountImpl>
    implements _$$AddOrUpdatePostInAccountImplCopyWith<$Res> {
  __$$AddOrUpdatePostInAccountImplCopyWithImpl(
      _$AddOrUpdatePostInAccountImpl _value,
      $Res Function(_$AddOrUpdatePostInAccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
  }) {
    return _then(_$AddOrUpdatePostInAccountImpl(
      null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }
}

/// @nodoc

class _$AddOrUpdatePostInAccountImpl implements AddOrUpdatePostInAccount {
  const _$AddOrUpdatePostInAccountImpl(this.post);

  @override
  final Post post;

  @override
  String toString() {
    return 'AccountEvent.addOrUpdatePostInAccount(post: $post)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddOrUpdatePostInAccountImpl &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddOrUpdatePostInAccountImplCopyWith<_$AddOrUpdatePostInAccountImpl>
      get copyWith => __$$AddOrUpdatePostInAccountImplCopyWithImpl<
          _$AddOrUpdatePostInAccountImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadAccountData,
    required TResult Function(
            UserPreference preferences, bool markOnboardingComplete)
        updateUserPreferences,
    required TResult Function(
            String userName, String userBio, String userBioLink)
        updateUserProfile,
    required TResult Function(String userUID) checkOnboardingStatus,
    required TResult Function(String postId, String userUID) likePostInAccount,
    required TResult Function(Post post) addOrUpdatePostInAccount,
  }) {
    return addOrUpdatePostInAccount(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadAccountData,
    TResult? Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult? Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult? Function(String userUID)? checkOnboardingStatus,
    TResult? Function(String postId, String userUID)? likePostInAccount,
    TResult? Function(Post post)? addOrUpdatePostInAccount,
  }) {
    return addOrUpdatePostInAccount?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadAccountData,
    TResult Function(UserPreference preferences, bool markOnboardingComplete)?
        updateUserPreferences,
    TResult Function(String userName, String userBio, String userBioLink)?
        updateUserProfile,
    TResult Function(String userUID)? checkOnboardingStatus,
    TResult Function(String postId, String userUID)? likePostInAccount,
    TResult Function(Post post)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (addOrUpdatePostInAccount != null) {
      return addOrUpdatePostInAccount(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAccountData value) loadAccountData,
    required TResult Function(UpdateUserPreferences value)
        updateUserPreferences,
    required TResult Function(UpdateUserProfile value) updateUserProfile,
    required TResult Function(CheckOnboardingStatus value)
        checkOnboardingStatus,
    required TResult Function(LikePostInAccount value) likePostInAccount,
    required TResult Function(AddOrUpdatePostInAccount value)
        addOrUpdatePostInAccount,
  }) {
    return addOrUpdatePostInAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAccountData value)? loadAccountData,
    TResult? Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult? Function(UpdateUserProfile value)? updateUserProfile,
    TResult? Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult? Function(LikePostInAccount value)? likePostInAccount,
    TResult? Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
  }) {
    return addOrUpdatePostInAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAccountData value)? loadAccountData,
    TResult Function(UpdateUserPreferences value)? updateUserPreferences,
    TResult Function(UpdateUserProfile value)? updateUserProfile,
    TResult Function(CheckOnboardingStatus value)? checkOnboardingStatus,
    TResult Function(LikePostInAccount value)? likePostInAccount,
    TResult Function(AddOrUpdatePostInAccount value)? addOrUpdatePostInAccount,
    required TResult orElse(),
  }) {
    if (addOrUpdatePostInAccount != null) {
      return addOrUpdatePostInAccount(this);
    }
    return orElse();
  }
}

abstract class AddOrUpdatePostInAccount implements AccountEvent {
  const factory AddOrUpdatePostInAccount(final Post post) =
      _$AddOrUpdatePostInAccountImpl;

  Post get post;

  /// Create a copy of AccountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddOrUpdatePostInAccountImplCopyWith<_$AddOrUpdatePostInAccountImpl>
      get copyWith => throw _privateConstructorUsedError;
}
