// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkRequested,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function() emailVerificationRequested,
    required TResult Function(dynamic user) userChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkRequested,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function()? emailVerificationRequested,
    TResult? Function(dynamic user)? userChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkRequested,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(String email)? passwordResetRequested,
    TResult Function()? emailVerificationRequested,
    TResult Function(dynamic user)? userChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCheckRequested value) checkRequested,
    required TResult Function(AuthSignInRequested value) signInRequested,
    required TResult Function(AuthSignUpRequested value) signUpRequested,
    required TResult Function(AuthSignOutRequested value) signOutRequested,
    required TResult Function(AuthPasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(AuthEmailVerificationRequested value)
        emailVerificationRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCheckRequested value)? checkRequested,
    TResult? Function(AuthSignInRequested value)? signInRequested,
    TResult? Function(AuthSignUpRequested value)? signUpRequested,
    TResult? Function(AuthSignOutRequested value)? signOutRequested,
    TResult? Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult? Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCheckRequested value)? checkRequested,
    TResult Function(AuthSignInRequested value)? signInRequested,
    TResult Function(AuthSignUpRequested value)? signUpRequested,
    TResult Function(AuthSignOutRequested value)? signOutRequested,
    TResult Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthCheckRequestedImplCopyWith<$Res> {
  factory _$$AuthCheckRequestedImplCopyWith(_$AuthCheckRequestedImpl value,
          $Res Function(_$AuthCheckRequestedImpl) then) =
      __$$AuthCheckRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthCheckRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthCheckRequestedImpl>
    implements _$$AuthCheckRequestedImplCopyWith<$Res> {
  __$$AuthCheckRequestedImplCopyWithImpl(_$AuthCheckRequestedImpl _value,
      $Res Function(_$AuthCheckRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthCheckRequestedImpl implements AuthCheckRequested {
  const _$AuthCheckRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.checkRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthCheckRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkRequested,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function() emailVerificationRequested,
    required TResult Function(dynamic user) userChanged,
  }) {
    return checkRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkRequested,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function()? emailVerificationRequested,
    TResult? Function(dynamic user)? userChanged,
  }) {
    return checkRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkRequested,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(String email)? passwordResetRequested,
    TResult Function()? emailVerificationRequested,
    TResult Function(dynamic user)? userChanged,
    required TResult orElse(),
  }) {
    if (checkRequested != null) {
      return checkRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCheckRequested value) checkRequested,
    required TResult Function(AuthSignInRequested value) signInRequested,
    required TResult Function(AuthSignUpRequested value) signUpRequested,
    required TResult Function(AuthSignOutRequested value) signOutRequested,
    required TResult Function(AuthPasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(AuthEmailVerificationRequested value)
        emailVerificationRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return checkRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCheckRequested value)? checkRequested,
    TResult? Function(AuthSignInRequested value)? signInRequested,
    TResult? Function(AuthSignUpRequested value)? signUpRequested,
    TResult? Function(AuthSignOutRequested value)? signOutRequested,
    TResult? Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult? Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return checkRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCheckRequested value)? checkRequested,
    TResult Function(AuthSignInRequested value)? signInRequested,
    TResult Function(AuthSignUpRequested value)? signUpRequested,
    TResult Function(AuthSignOutRequested value)? signOutRequested,
    TResult Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (checkRequested != null) {
      return checkRequested(this);
    }
    return orElse();
  }
}

abstract class AuthCheckRequested implements AuthEvent {
  const factory AuthCheckRequested() = _$AuthCheckRequestedImpl;
}

/// @nodoc
abstract class _$$AuthSignInRequestedImplCopyWith<$Res> {
  factory _$$AuthSignInRequestedImplCopyWith(_$AuthSignInRequestedImpl value,
          $Res Function(_$AuthSignInRequestedImpl) then) =
      __$$AuthSignInRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$AuthSignInRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthSignInRequestedImpl>
    implements _$$AuthSignInRequestedImplCopyWith<$Res> {
  __$$AuthSignInRequestedImplCopyWithImpl(_$AuthSignInRequestedImpl _value,
      $Res Function(_$AuthSignInRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$AuthSignInRequestedImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthSignInRequestedImpl implements AuthSignInRequested {
  const _$AuthSignInRequestedImpl(
      {required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.signInRequested(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSignInRequestedImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSignInRequestedImplCopyWith<_$AuthSignInRequestedImpl> get copyWith =>
      __$$AuthSignInRequestedImplCopyWithImpl<_$AuthSignInRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkRequested,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function() emailVerificationRequested,
    required TResult Function(dynamic user) userChanged,
  }) {
    return signInRequested(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkRequested,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function()? emailVerificationRequested,
    TResult? Function(dynamic user)? userChanged,
  }) {
    return signInRequested?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkRequested,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(String email)? passwordResetRequested,
    TResult Function()? emailVerificationRequested,
    TResult Function(dynamic user)? userChanged,
    required TResult orElse(),
  }) {
    if (signInRequested != null) {
      return signInRequested(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCheckRequested value) checkRequested,
    required TResult Function(AuthSignInRequested value) signInRequested,
    required TResult Function(AuthSignUpRequested value) signUpRequested,
    required TResult Function(AuthSignOutRequested value) signOutRequested,
    required TResult Function(AuthPasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(AuthEmailVerificationRequested value)
        emailVerificationRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return signInRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCheckRequested value)? checkRequested,
    TResult? Function(AuthSignInRequested value)? signInRequested,
    TResult? Function(AuthSignUpRequested value)? signUpRequested,
    TResult? Function(AuthSignOutRequested value)? signOutRequested,
    TResult? Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult? Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return signInRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCheckRequested value)? checkRequested,
    TResult Function(AuthSignInRequested value)? signInRequested,
    TResult Function(AuthSignUpRequested value)? signUpRequested,
    TResult Function(AuthSignOutRequested value)? signOutRequested,
    TResult Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (signInRequested != null) {
      return signInRequested(this);
    }
    return orElse();
  }
}

abstract class AuthSignInRequested implements AuthEvent {
  const factory AuthSignInRequested(
      {required final String email,
      required final String password}) = _$AuthSignInRequestedImpl;

  String get email;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthSignInRequestedImplCopyWith<_$AuthSignInRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthSignUpRequestedImplCopyWith<$Res> {
  factory _$$AuthSignUpRequestedImplCopyWith(_$AuthSignUpRequestedImpl value,
          $Res Function(_$AuthSignUpRequestedImpl) then) =
      __$$AuthSignUpRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password, String? displayName});
}

/// @nodoc
class __$$AuthSignUpRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthSignUpRequestedImpl>
    implements _$$AuthSignUpRequestedImplCopyWith<$Res> {
  __$$AuthSignUpRequestedImplCopyWithImpl(_$AuthSignUpRequestedImpl _value,
      $Res Function(_$AuthSignUpRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? displayName = freezed,
  }) {
    return _then(_$AuthSignUpRequestedImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthSignUpRequestedImpl implements AuthSignUpRequested {
  const _$AuthSignUpRequestedImpl(
      {required this.email, required this.password, this.displayName});

  @override
  final String email;
  @override
  final String password;
  @override
  final String? displayName;

  @override
  String toString() {
    return 'AuthEvent.signUpRequested(email: $email, password: $password, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSignUpRequestedImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password, displayName);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSignUpRequestedImplCopyWith<_$AuthSignUpRequestedImpl> get copyWith =>
      __$$AuthSignUpRequestedImplCopyWithImpl<_$AuthSignUpRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkRequested,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function() emailVerificationRequested,
    required TResult Function(dynamic user) userChanged,
  }) {
    return signUpRequested(email, password, displayName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkRequested,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function()? emailVerificationRequested,
    TResult? Function(dynamic user)? userChanged,
  }) {
    return signUpRequested?.call(email, password, displayName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkRequested,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(String email)? passwordResetRequested,
    TResult Function()? emailVerificationRequested,
    TResult Function(dynamic user)? userChanged,
    required TResult orElse(),
  }) {
    if (signUpRequested != null) {
      return signUpRequested(email, password, displayName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCheckRequested value) checkRequested,
    required TResult Function(AuthSignInRequested value) signInRequested,
    required TResult Function(AuthSignUpRequested value) signUpRequested,
    required TResult Function(AuthSignOutRequested value) signOutRequested,
    required TResult Function(AuthPasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(AuthEmailVerificationRequested value)
        emailVerificationRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return signUpRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCheckRequested value)? checkRequested,
    TResult? Function(AuthSignInRequested value)? signInRequested,
    TResult? Function(AuthSignUpRequested value)? signUpRequested,
    TResult? Function(AuthSignOutRequested value)? signOutRequested,
    TResult? Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult? Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return signUpRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCheckRequested value)? checkRequested,
    TResult Function(AuthSignInRequested value)? signInRequested,
    TResult Function(AuthSignUpRequested value)? signUpRequested,
    TResult Function(AuthSignOutRequested value)? signOutRequested,
    TResult Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (signUpRequested != null) {
      return signUpRequested(this);
    }
    return orElse();
  }
}

abstract class AuthSignUpRequested implements AuthEvent {
  const factory AuthSignUpRequested(
      {required final String email,
      required final String password,
      final String? displayName}) = _$AuthSignUpRequestedImpl;

  String get email;
  String get password;
  String? get displayName;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthSignUpRequestedImplCopyWith<_$AuthSignUpRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthSignOutRequestedImplCopyWith<$Res> {
  factory _$$AuthSignOutRequestedImplCopyWith(_$AuthSignOutRequestedImpl value,
          $Res Function(_$AuthSignOutRequestedImpl) then) =
      __$$AuthSignOutRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthSignOutRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthSignOutRequestedImpl>
    implements _$$AuthSignOutRequestedImplCopyWith<$Res> {
  __$$AuthSignOutRequestedImplCopyWithImpl(_$AuthSignOutRequestedImpl _value,
      $Res Function(_$AuthSignOutRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthSignOutRequestedImpl implements AuthSignOutRequested {
  const _$AuthSignOutRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.signOutRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSignOutRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkRequested,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function() emailVerificationRequested,
    required TResult Function(dynamic user) userChanged,
  }) {
    return signOutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkRequested,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function()? emailVerificationRequested,
    TResult? Function(dynamic user)? userChanged,
  }) {
    return signOutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkRequested,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(String email)? passwordResetRequested,
    TResult Function()? emailVerificationRequested,
    TResult Function(dynamic user)? userChanged,
    required TResult orElse(),
  }) {
    if (signOutRequested != null) {
      return signOutRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCheckRequested value) checkRequested,
    required TResult Function(AuthSignInRequested value) signInRequested,
    required TResult Function(AuthSignUpRequested value) signUpRequested,
    required TResult Function(AuthSignOutRequested value) signOutRequested,
    required TResult Function(AuthPasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(AuthEmailVerificationRequested value)
        emailVerificationRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return signOutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCheckRequested value)? checkRequested,
    TResult? Function(AuthSignInRequested value)? signInRequested,
    TResult? Function(AuthSignUpRequested value)? signUpRequested,
    TResult? Function(AuthSignOutRequested value)? signOutRequested,
    TResult? Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult? Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return signOutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCheckRequested value)? checkRequested,
    TResult Function(AuthSignInRequested value)? signInRequested,
    TResult Function(AuthSignUpRequested value)? signUpRequested,
    TResult Function(AuthSignOutRequested value)? signOutRequested,
    TResult Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (signOutRequested != null) {
      return signOutRequested(this);
    }
    return orElse();
  }
}

abstract class AuthSignOutRequested implements AuthEvent {
  const factory AuthSignOutRequested() = _$AuthSignOutRequestedImpl;
}

/// @nodoc
abstract class _$$AuthPasswordResetRequestedImplCopyWith<$Res> {
  factory _$$AuthPasswordResetRequestedImplCopyWith(
          _$AuthPasswordResetRequestedImpl value,
          $Res Function(_$AuthPasswordResetRequestedImpl) then) =
      __$$AuthPasswordResetRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$AuthPasswordResetRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthPasswordResetRequestedImpl>
    implements _$$AuthPasswordResetRequestedImplCopyWith<$Res> {
  __$$AuthPasswordResetRequestedImplCopyWithImpl(
      _$AuthPasswordResetRequestedImpl _value,
      $Res Function(_$AuthPasswordResetRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$AuthPasswordResetRequestedImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthPasswordResetRequestedImpl implements AuthPasswordResetRequested {
  const _$AuthPasswordResetRequestedImpl({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'AuthEvent.passwordResetRequested(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthPasswordResetRequestedImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthPasswordResetRequestedImplCopyWith<_$AuthPasswordResetRequestedImpl>
      get copyWith => __$$AuthPasswordResetRequestedImplCopyWithImpl<
          _$AuthPasswordResetRequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkRequested,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function() emailVerificationRequested,
    required TResult Function(dynamic user) userChanged,
  }) {
    return passwordResetRequested(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkRequested,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function()? emailVerificationRequested,
    TResult? Function(dynamic user)? userChanged,
  }) {
    return passwordResetRequested?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkRequested,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(String email)? passwordResetRequested,
    TResult Function()? emailVerificationRequested,
    TResult Function(dynamic user)? userChanged,
    required TResult orElse(),
  }) {
    if (passwordResetRequested != null) {
      return passwordResetRequested(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCheckRequested value) checkRequested,
    required TResult Function(AuthSignInRequested value) signInRequested,
    required TResult Function(AuthSignUpRequested value) signUpRequested,
    required TResult Function(AuthSignOutRequested value) signOutRequested,
    required TResult Function(AuthPasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(AuthEmailVerificationRequested value)
        emailVerificationRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return passwordResetRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCheckRequested value)? checkRequested,
    TResult? Function(AuthSignInRequested value)? signInRequested,
    TResult? Function(AuthSignUpRequested value)? signUpRequested,
    TResult? Function(AuthSignOutRequested value)? signOutRequested,
    TResult? Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult? Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return passwordResetRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCheckRequested value)? checkRequested,
    TResult Function(AuthSignInRequested value)? signInRequested,
    TResult Function(AuthSignUpRequested value)? signUpRequested,
    TResult Function(AuthSignOutRequested value)? signOutRequested,
    TResult Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (passwordResetRequested != null) {
      return passwordResetRequested(this);
    }
    return orElse();
  }
}

abstract class AuthPasswordResetRequested implements AuthEvent {
  const factory AuthPasswordResetRequested({required final String email}) =
      _$AuthPasswordResetRequestedImpl;

  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthPasswordResetRequestedImplCopyWith<_$AuthPasswordResetRequestedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthEmailVerificationRequestedImplCopyWith<$Res> {
  factory _$$AuthEmailVerificationRequestedImplCopyWith(
          _$AuthEmailVerificationRequestedImpl value,
          $Res Function(_$AuthEmailVerificationRequestedImpl) then) =
      __$$AuthEmailVerificationRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthEmailVerificationRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthEmailVerificationRequestedImpl>
    implements _$$AuthEmailVerificationRequestedImplCopyWith<$Res> {
  __$$AuthEmailVerificationRequestedImplCopyWithImpl(
      _$AuthEmailVerificationRequestedImpl _value,
      $Res Function(_$AuthEmailVerificationRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthEmailVerificationRequestedImpl
    implements AuthEmailVerificationRequested {
  const _$AuthEmailVerificationRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.emailVerificationRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthEmailVerificationRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkRequested,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function() emailVerificationRequested,
    required TResult Function(dynamic user) userChanged,
  }) {
    return emailVerificationRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkRequested,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function()? emailVerificationRequested,
    TResult? Function(dynamic user)? userChanged,
  }) {
    return emailVerificationRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkRequested,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(String email)? passwordResetRequested,
    TResult Function()? emailVerificationRequested,
    TResult Function(dynamic user)? userChanged,
    required TResult orElse(),
  }) {
    if (emailVerificationRequested != null) {
      return emailVerificationRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCheckRequested value) checkRequested,
    required TResult Function(AuthSignInRequested value) signInRequested,
    required TResult Function(AuthSignUpRequested value) signUpRequested,
    required TResult Function(AuthSignOutRequested value) signOutRequested,
    required TResult Function(AuthPasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(AuthEmailVerificationRequested value)
        emailVerificationRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return emailVerificationRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCheckRequested value)? checkRequested,
    TResult? Function(AuthSignInRequested value)? signInRequested,
    TResult? Function(AuthSignUpRequested value)? signUpRequested,
    TResult? Function(AuthSignOutRequested value)? signOutRequested,
    TResult? Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult? Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return emailVerificationRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCheckRequested value)? checkRequested,
    TResult Function(AuthSignInRequested value)? signInRequested,
    TResult Function(AuthSignUpRequested value)? signUpRequested,
    TResult Function(AuthSignOutRequested value)? signOutRequested,
    TResult Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (emailVerificationRequested != null) {
      return emailVerificationRequested(this);
    }
    return orElse();
  }
}

abstract class AuthEmailVerificationRequested implements AuthEvent {
  const factory AuthEmailVerificationRequested() =
      _$AuthEmailVerificationRequestedImpl;
}

/// @nodoc
abstract class _$$AuthUserChangedImplCopyWith<$Res> {
  factory _$$AuthUserChangedImplCopyWith(_$AuthUserChangedImpl value,
          $Res Function(_$AuthUserChangedImpl) then) =
      __$$AuthUserChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic user});
}

/// @nodoc
class __$$AuthUserChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthUserChangedImpl>
    implements _$$AuthUserChangedImplCopyWith<$Res> {
  __$$AuthUserChangedImplCopyWithImpl(
      _$AuthUserChangedImpl _value, $Res Function(_$AuthUserChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$AuthUserChangedImpl(
      freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$AuthUserChangedImpl implements AuthUserChanged {
  const _$AuthUserChangedImpl(this.user);

  @override
  final dynamic user;

  @override
  String toString() {
    return 'AuthEvent.userChanged(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserChangedImpl &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(user));

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserChangedImplCopyWith<_$AuthUserChangedImpl> get copyWith =>
      __$$AuthUserChangedImplCopyWithImpl<_$AuthUserChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkRequested,
    required TResult Function(String email, String password) signInRequested,
    required TResult Function(
            String email, String password, String? displayName)
        signUpRequested,
    required TResult Function() signOutRequested,
    required TResult Function(String email) passwordResetRequested,
    required TResult Function() emailVerificationRequested,
    required TResult Function(dynamic user) userChanged,
  }) {
    return userChanged(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkRequested,
    TResult? Function(String email, String password)? signInRequested,
    TResult? Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult? Function()? signOutRequested,
    TResult? Function(String email)? passwordResetRequested,
    TResult? Function()? emailVerificationRequested,
    TResult? Function(dynamic user)? userChanged,
  }) {
    return userChanged?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkRequested,
    TResult Function(String email, String password)? signInRequested,
    TResult Function(String email, String password, String? displayName)?
        signUpRequested,
    TResult Function()? signOutRequested,
    TResult Function(String email)? passwordResetRequested,
    TResult Function()? emailVerificationRequested,
    TResult Function(dynamic user)? userChanged,
    required TResult orElse(),
  }) {
    if (userChanged != null) {
      return userChanged(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCheckRequested value) checkRequested,
    required TResult Function(AuthSignInRequested value) signInRequested,
    required TResult Function(AuthSignUpRequested value) signUpRequested,
    required TResult Function(AuthSignOutRequested value) signOutRequested,
    required TResult Function(AuthPasswordResetRequested value)
        passwordResetRequested,
    required TResult Function(AuthEmailVerificationRequested value)
        emailVerificationRequested,
    required TResult Function(AuthUserChanged value) userChanged,
  }) {
    return userChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCheckRequested value)? checkRequested,
    TResult? Function(AuthSignInRequested value)? signInRequested,
    TResult? Function(AuthSignUpRequested value)? signUpRequested,
    TResult? Function(AuthSignOutRequested value)? signOutRequested,
    TResult? Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult? Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult? Function(AuthUserChanged value)? userChanged,
  }) {
    return userChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCheckRequested value)? checkRequested,
    TResult Function(AuthSignInRequested value)? signInRequested,
    TResult Function(AuthSignUpRequested value)? signUpRequested,
    TResult Function(AuthSignOutRequested value)? signOutRequested,
    TResult Function(AuthPasswordResetRequested value)? passwordResetRequested,
    TResult Function(AuthEmailVerificationRequested value)?
        emailVerificationRequested,
    TResult Function(AuthUserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    if (userChanged != null) {
      return userChanged(this);
    }
    return orElse();
  }
}

abstract class AuthUserChanged implements AuthEvent {
  const factory AuthUserChanged(final dynamic user) = _$AuthUserChangedImpl;

  dynamic get user;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthUserChangedImplCopyWith<_$AuthUserChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
