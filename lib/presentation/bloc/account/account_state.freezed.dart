// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingPosts => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  UserPreference? get preferences => throw _privateConstructorUsedError;
  List<Post> get posts => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// True if user has completed onboarding (has saved preferences).
  bool? get hasCompletedOnboarding => throw _privateConstructorUsedError;

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountStateCopyWith<AccountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountStateCopyWith<$Res> {
  factory $AccountStateCopyWith(
          AccountState value, $Res Function(AccountState) then) =
      _$AccountStateCopyWithImpl<$Res, AccountState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingPosts,
      bool isSaving,
      User? user,
      UserPreference? preferences,
      List<Post> posts,
      String? errorMessage,
      bool? hasCompletedOnboarding});
}

/// @nodoc
class _$AccountStateCopyWithImpl<$Res, $Val extends AccountState>
    implements $AccountStateCopyWith<$Res> {
  _$AccountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingPosts = null,
    Object? isSaving = null,
    Object? user = freezed,
    Object? preferences = freezed,
    Object? posts = null,
    Object? errorMessage = freezed,
    Object? hasCompletedOnboarding = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingPosts: null == isLoadingPosts
          ? _value.isLoadingPosts
          : isLoadingPosts // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreference?,
      posts: null == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasCompletedOnboarding: freezed == hasCompletedOnboarding
          ? _value.hasCompletedOnboarding
          : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountStateImplCopyWith<$Res>
    implements $AccountStateCopyWith<$Res> {
  factory _$$AccountStateImplCopyWith(
          _$AccountStateImpl value, $Res Function(_$AccountStateImpl) then) =
      __$$AccountStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isLoadingPosts,
      bool isSaving,
      User? user,
      UserPreference? preferences,
      List<Post> posts,
      String? errorMessage,
      bool? hasCompletedOnboarding});
}

/// @nodoc
class __$$AccountStateImplCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountStateImpl>
    implements _$$AccountStateImplCopyWith<$Res> {
  __$$AccountStateImplCopyWithImpl(
      _$AccountStateImpl _value, $Res Function(_$AccountStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingPosts = null,
    Object? isSaving = null,
    Object? user = freezed,
    Object? preferences = freezed,
    Object? posts = null,
    Object? errorMessage = freezed,
    Object? hasCompletedOnboarding = freezed,
  }) {
    return _then(_$AccountStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingPosts: null == isLoadingPosts
          ? _value.isLoadingPosts
          : isLoadingPosts // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as UserPreference?,
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasCompletedOnboarding: freezed == hasCompletedOnboarding
          ? _value.hasCompletedOnboarding
          : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$AccountStateImpl implements _AccountState {
  const _$AccountStateImpl(
      {this.isLoading = false,
      this.isLoadingPosts = false,
      this.isSaving = false,
      this.user,
      this.preferences,
      final List<Post> posts = const [],
      this.errorMessage,
      this.hasCompletedOnboarding})
      : _posts = posts;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingPosts;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  final User? user;
  @override
  final UserPreference? preferences;
  final List<Post> _posts;
  @override
  @JsonKey()
  List<Post> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  final String? errorMessage;

  /// True if user has completed onboarding (has saved preferences).
  @override
  final bool? hasCompletedOnboarding;

  @override
  String toString() {
    return 'AccountState(isLoading: $isLoading, isLoadingPosts: $isLoadingPosts, isSaving: $isSaving, user: $user, preferences: $preferences, posts: $posts, errorMessage: $errorMessage, hasCompletedOnboarding: $hasCompletedOnboarding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingPosts, isLoadingPosts) ||
                other.isLoadingPosts == isLoadingPosts) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.hasCompletedOnboarding, hasCompletedOnboarding) ||
                other.hasCompletedOnboarding == hasCompletedOnboarding));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isLoadingPosts,
      isSaving,
      user,
      preferences,
      const DeepCollectionEquality().hash(_posts),
      errorMessage,
      hasCompletedOnboarding);

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountStateImplCopyWith<_$AccountStateImpl> get copyWith =>
      __$$AccountStateImplCopyWithImpl<_$AccountStateImpl>(this, _$identity);
}

abstract class _AccountState implements AccountState {
  const factory _AccountState(
      {final bool isLoading,
      final bool isLoadingPosts,
      final bool isSaving,
      final User? user,
      final UserPreference? preferences,
      final List<Post> posts,
      final String? errorMessage,
      final bool? hasCompletedOnboarding}) = _$AccountStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLoadingPosts;
  @override
  bool get isSaving;
  @override
  User? get user;
  @override
  UserPreference? get preferences;
  @override
  List<Post> get posts;
  @override
  String? get errorMessage;

  /// True if user has completed onboarding (has saved preferences).
  @override
  bool? get hasCompletedOnboarding;

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountStateImplCopyWith<_$AccountStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
