// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ManageState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<DropTask> get tasks => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ManageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ManageStateCopyWith<ManageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManageStateCopyWith<$Res> {
  factory $ManageStateCopyWith(
          ManageState value, $Res Function(ManageState) then) =
      _$ManageStateCopyWithImpl<$Res, ManageState>;
  @useResult
  $Res call({bool isLoading, List<DropTask> tasks, String? errorMessage});
}

/// @nodoc
class _$ManageStateCopyWithImpl<$Res, $Val extends ManageState>
    implements $ManageStateCopyWith<$Res> {
  _$ManageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? tasks = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<DropTask>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ManageStateImplCopyWith<$Res>
    implements $ManageStateCopyWith<$Res> {
  factory _$$ManageStateImplCopyWith(
          _$ManageStateImpl value, $Res Function(_$ManageStateImpl) then) =
      __$$ManageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<DropTask> tasks, String? errorMessage});
}

/// @nodoc
class __$$ManageStateImplCopyWithImpl<$Res>
    extends _$ManageStateCopyWithImpl<$Res, _$ManageStateImpl>
    implements _$$ManageStateImplCopyWith<$Res> {
  __$$ManageStateImplCopyWithImpl(
      _$ManageStateImpl _value, $Res Function(_$ManageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? tasks = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ManageStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<DropTask>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ManageStateImpl implements _ManageState {
  const _$ManageStateImpl(
      {this.isLoading = false,
      final List<DropTask> tasks = const [],
      this.errorMessage})
      : _tasks = tasks;

  @override
  @JsonKey()
  final bool isLoading;
  final List<DropTask> _tasks;
  @override
  @JsonKey()
  List<DropTask> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ManageState(isLoading: $isLoading, tasks: $tasks, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManageStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_tasks), errorMessage);

  /// Create a copy of ManageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ManageStateImplCopyWith<_$ManageStateImpl> get copyWith =>
      __$$ManageStateImplCopyWithImpl<_$ManageStateImpl>(this, _$identity);
}

abstract class _ManageState implements ManageState {
  const factory _ManageState(
      {final bool isLoading,
      final List<DropTask> tasks,
      final String? errorMessage}) = _$ManageStateImpl;

  @override
  bool get isLoading;
  @override
  List<DropTask> get tasks;
  @override
  String? get errorMessage;

  /// Create a copy of ManageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ManageStateImplCopyWith<_$ManageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
