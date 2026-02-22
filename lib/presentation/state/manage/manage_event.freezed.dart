// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ManageEvent {
  String get userUID => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadTasks,
    required TResult Function(String title, String userUID) addTask,
    required TResult Function(String taskId, String status, String userUID)
        updateTaskStatus,
    required TResult Function(String taskId, String userUID) deleteTask,
    required TResult Function(String userUID) refreshTasks,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadTasks,
    TResult? Function(String title, String userUID)? addTask,
    TResult? Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult? Function(String taskId, String userUID)? deleteTask,
    TResult? Function(String userUID)? refreshTasks,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadTasks,
    TResult Function(String title, String userUID)? addTask,
    TResult Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult Function(String taskId, String userUID)? deleteTask,
    TResult Function(String userUID)? refreshTasks,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTasks value) loadTasks,
    required TResult Function(AddTask value) addTask,
    required TResult Function(UpdateTaskStatus value) updateTaskStatus,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(RefreshTasks value) refreshTasks,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTasks value)? loadTasks,
    TResult? Function(AddTask value)? addTask,
    TResult? Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(RefreshTasks value)? refreshTasks,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTasks value)? loadTasks,
    TResult Function(AddTask value)? addTask,
    TResult Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(RefreshTasks value)? refreshTasks,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ManageEventCopyWith<ManageEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManageEventCopyWith<$Res> {
  factory $ManageEventCopyWith(
          ManageEvent value, $Res Function(ManageEvent) then) =
      _$ManageEventCopyWithImpl<$Res, ManageEvent>;
  @useResult
  $Res call({String userUID});
}

/// @nodoc
class _$ManageEventCopyWithImpl<$Res, $Val extends ManageEvent>
    implements $ManageEventCopyWith<$Res> {
  _$ManageEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = null,
  }) {
    return _then(_value.copyWith(
      userUID: null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadTasksImplCopyWith<$Res>
    implements $ManageEventCopyWith<$Res> {
  factory _$$LoadTasksImplCopyWith(
          _$LoadTasksImpl value, $Res Function(_$LoadTasksImpl) then) =
      __$$LoadTasksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userUID});
}

/// @nodoc
class __$$LoadTasksImplCopyWithImpl<$Res>
    extends _$ManageEventCopyWithImpl<$Res, _$LoadTasksImpl>
    implements _$$LoadTasksImplCopyWith<$Res> {
  __$$LoadTasksImplCopyWithImpl(
      _$LoadTasksImpl _value, $Res Function(_$LoadTasksImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = null,
  }) {
    return _then(_$LoadTasksImpl(
      null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadTasksImpl implements LoadTasks {
  const _$LoadTasksImpl(this.userUID);

  @override
  final String userUID;

  @override
  String toString() {
    return 'ManageEvent.loadTasks(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadTasksImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadTasksImplCopyWith<_$LoadTasksImpl> get copyWith =>
      __$$LoadTasksImplCopyWithImpl<_$LoadTasksImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadTasks,
    required TResult Function(String title, String userUID) addTask,
    required TResult Function(String taskId, String status, String userUID)
        updateTaskStatus,
    required TResult Function(String taskId, String userUID) deleteTask,
    required TResult Function(String userUID) refreshTasks,
  }) {
    return loadTasks(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadTasks,
    TResult? Function(String title, String userUID)? addTask,
    TResult? Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult? Function(String taskId, String userUID)? deleteTask,
    TResult? Function(String userUID)? refreshTasks,
  }) {
    return loadTasks?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadTasks,
    TResult Function(String title, String userUID)? addTask,
    TResult Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult Function(String taskId, String userUID)? deleteTask,
    TResult Function(String userUID)? refreshTasks,
    required TResult orElse(),
  }) {
    if (loadTasks != null) {
      return loadTasks(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTasks value) loadTasks,
    required TResult Function(AddTask value) addTask,
    required TResult Function(UpdateTaskStatus value) updateTaskStatus,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(RefreshTasks value) refreshTasks,
  }) {
    return loadTasks(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTasks value)? loadTasks,
    TResult? Function(AddTask value)? addTask,
    TResult? Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(RefreshTasks value)? refreshTasks,
  }) {
    return loadTasks?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTasks value)? loadTasks,
    TResult Function(AddTask value)? addTask,
    TResult Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(RefreshTasks value)? refreshTasks,
    required TResult orElse(),
  }) {
    if (loadTasks != null) {
      return loadTasks(this);
    }
    return orElse();
  }
}

abstract class LoadTasks implements ManageEvent {
  const factory LoadTasks(final String userUID) = _$LoadTasksImpl;

  @override
  String get userUID;

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadTasksImplCopyWith<_$LoadTasksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddTaskImplCopyWith<$Res>
    implements $ManageEventCopyWith<$Res> {
  factory _$$AddTaskImplCopyWith(
          _$AddTaskImpl value, $Res Function(_$AddTaskImpl) then) =
      __$$AddTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String userUID});
}

/// @nodoc
class __$$AddTaskImplCopyWithImpl<$Res>
    extends _$ManageEventCopyWithImpl<$Res, _$AddTaskImpl>
    implements _$$AddTaskImplCopyWith<$Res> {
  __$$AddTaskImplCopyWithImpl(
      _$AddTaskImpl _value, $Res Function(_$AddTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? userUID = null,
  }) {
    return _then(_$AddTaskImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userUID: null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddTaskImpl implements AddTask {
  const _$AddTaskImpl({required this.title, required this.userUID});

  @override
  final String title;
  @override
  final String userUID;

  @override
  String toString() {
    return 'ManageEvent.addTask(title: $title, userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTaskImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, userUID);

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTaskImplCopyWith<_$AddTaskImpl> get copyWith =>
      __$$AddTaskImplCopyWithImpl<_$AddTaskImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadTasks,
    required TResult Function(String title, String userUID) addTask,
    required TResult Function(String taskId, String status, String userUID)
        updateTaskStatus,
    required TResult Function(String taskId, String userUID) deleteTask,
    required TResult Function(String userUID) refreshTasks,
  }) {
    return addTask(title, userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadTasks,
    TResult? Function(String title, String userUID)? addTask,
    TResult? Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult? Function(String taskId, String userUID)? deleteTask,
    TResult? Function(String userUID)? refreshTasks,
  }) {
    return addTask?.call(title, userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadTasks,
    TResult Function(String title, String userUID)? addTask,
    TResult Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult Function(String taskId, String userUID)? deleteTask,
    TResult Function(String userUID)? refreshTasks,
    required TResult orElse(),
  }) {
    if (addTask != null) {
      return addTask(title, userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTasks value) loadTasks,
    required TResult Function(AddTask value) addTask,
    required TResult Function(UpdateTaskStatus value) updateTaskStatus,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(RefreshTasks value) refreshTasks,
  }) {
    return addTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTasks value)? loadTasks,
    TResult? Function(AddTask value)? addTask,
    TResult? Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(RefreshTasks value)? refreshTasks,
  }) {
    return addTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTasks value)? loadTasks,
    TResult Function(AddTask value)? addTask,
    TResult Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(RefreshTasks value)? refreshTasks,
    required TResult orElse(),
  }) {
    if (addTask != null) {
      return addTask(this);
    }
    return orElse();
  }
}

abstract class AddTask implements ManageEvent {
  const factory AddTask(
      {required final String title,
      required final String userUID}) = _$AddTaskImpl;

  String get title;
  @override
  String get userUID;

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTaskImplCopyWith<_$AddTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTaskStatusImplCopyWith<$Res>
    implements $ManageEventCopyWith<$Res> {
  factory _$$UpdateTaskStatusImplCopyWith(_$UpdateTaskStatusImpl value,
          $Res Function(_$UpdateTaskStatusImpl) then) =
      __$$UpdateTaskStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String taskId, String status, String userUID});
}

/// @nodoc
class __$$UpdateTaskStatusImplCopyWithImpl<$Res>
    extends _$ManageEventCopyWithImpl<$Res, _$UpdateTaskStatusImpl>
    implements _$$UpdateTaskStatusImplCopyWith<$Res> {
  __$$UpdateTaskStatusImplCopyWithImpl(_$UpdateTaskStatusImpl _value,
      $Res Function(_$UpdateTaskStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? status = null,
    Object? userUID = null,
  }) {
    return _then(_$UpdateTaskStatusImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      userUID: null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateTaskStatusImpl implements UpdateTaskStatus {
  const _$UpdateTaskStatusImpl(
      {required this.taskId, required this.status, required this.userUID});

  @override
  final String taskId;
  @override
  final String status;
  @override
  final String userUID;

  @override
  String toString() {
    return 'ManageEvent.updateTaskStatus(taskId: $taskId, status: $status, userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTaskStatusImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId, status, userUID);

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTaskStatusImplCopyWith<_$UpdateTaskStatusImpl> get copyWith =>
      __$$UpdateTaskStatusImplCopyWithImpl<_$UpdateTaskStatusImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadTasks,
    required TResult Function(String title, String userUID) addTask,
    required TResult Function(String taskId, String status, String userUID)
        updateTaskStatus,
    required TResult Function(String taskId, String userUID) deleteTask,
    required TResult Function(String userUID) refreshTasks,
  }) {
    return updateTaskStatus(taskId, status, userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadTasks,
    TResult? Function(String title, String userUID)? addTask,
    TResult? Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult? Function(String taskId, String userUID)? deleteTask,
    TResult? Function(String userUID)? refreshTasks,
  }) {
    return updateTaskStatus?.call(taskId, status, userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadTasks,
    TResult Function(String title, String userUID)? addTask,
    TResult Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult Function(String taskId, String userUID)? deleteTask,
    TResult Function(String userUID)? refreshTasks,
    required TResult orElse(),
  }) {
    if (updateTaskStatus != null) {
      return updateTaskStatus(taskId, status, userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTasks value) loadTasks,
    required TResult Function(AddTask value) addTask,
    required TResult Function(UpdateTaskStatus value) updateTaskStatus,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(RefreshTasks value) refreshTasks,
  }) {
    return updateTaskStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTasks value)? loadTasks,
    TResult? Function(AddTask value)? addTask,
    TResult? Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(RefreshTasks value)? refreshTasks,
  }) {
    return updateTaskStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTasks value)? loadTasks,
    TResult Function(AddTask value)? addTask,
    TResult Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(RefreshTasks value)? refreshTasks,
    required TResult orElse(),
  }) {
    if (updateTaskStatus != null) {
      return updateTaskStatus(this);
    }
    return orElse();
  }
}

abstract class UpdateTaskStatus implements ManageEvent {
  const factory UpdateTaskStatus(
      {required final String taskId,
      required final String status,
      required final String userUID}) = _$UpdateTaskStatusImpl;

  String get taskId;
  String get status;
  @override
  String get userUID;

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTaskStatusImplCopyWith<_$UpdateTaskStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteTaskImplCopyWith<$Res>
    implements $ManageEventCopyWith<$Res> {
  factory _$$DeleteTaskImplCopyWith(
          _$DeleteTaskImpl value, $Res Function(_$DeleteTaskImpl) then) =
      __$$DeleteTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String taskId, String userUID});
}

/// @nodoc
class __$$DeleteTaskImplCopyWithImpl<$Res>
    extends _$ManageEventCopyWithImpl<$Res, _$DeleteTaskImpl>
    implements _$$DeleteTaskImplCopyWith<$Res> {
  __$$DeleteTaskImplCopyWithImpl(
      _$DeleteTaskImpl _value, $Res Function(_$DeleteTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? userUID = null,
  }) {
    return _then(_$DeleteTaskImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      userUID: null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteTaskImpl implements DeleteTask {
  const _$DeleteTaskImpl({required this.taskId, required this.userUID});

  @override
  final String taskId;
  @override
  final String userUID;

  @override
  String toString() {
    return 'ManageEvent.deleteTask(taskId: $taskId, userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteTaskImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId, userUID);

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteTaskImplCopyWith<_$DeleteTaskImpl> get copyWith =>
      __$$DeleteTaskImplCopyWithImpl<_$DeleteTaskImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadTasks,
    required TResult Function(String title, String userUID) addTask,
    required TResult Function(String taskId, String status, String userUID)
        updateTaskStatus,
    required TResult Function(String taskId, String userUID) deleteTask,
    required TResult Function(String userUID) refreshTasks,
  }) {
    return deleteTask(taskId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadTasks,
    TResult? Function(String title, String userUID)? addTask,
    TResult? Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult? Function(String taskId, String userUID)? deleteTask,
    TResult? Function(String userUID)? refreshTasks,
  }) {
    return deleteTask?.call(taskId, userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadTasks,
    TResult Function(String title, String userUID)? addTask,
    TResult Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult Function(String taskId, String userUID)? deleteTask,
    TResult Function(String userUID)? refreshTasks,
    required TResult orElse(),
  }) {
    if (deleteTask != null) {
      return deleteTask(taskId, userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTasks value) loadTasks,
    required TResult Function(AddTask value) addTask,
    required TResult Function(UpdateTaskStatus value) updateTaskStatus,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(RefreshTasks value) refreshTasks,
  }) {
    return deleteTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTasks value)? loadTasks,
    TResult? Function(AddTask value)? addTask,
    TResult? Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(RefreshTasks value)? refreshTasks,
  }) {
    return deleteTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTasks value)? loadTasks,
    TResult Function(AddTask value)? addTask,
    TResult Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(RefreshTasks value)? refreshTasks,
    required TResult orElse(),
  }) {
    if (deleteTask != null) {
      return deleteTask(this);
    }
    return orElse();
  }
}

abstract class DeleteTask implements ManageEvent {
  const factory DeleteTask(
      {required final String taskId,
      required final String userUID}) = _$DeleteTaskImpl;

  String get taskId;
  @override
  String get userUID;

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteTaskImplCopyWith<_$DeleteTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshTasksImplCopyWith<$Res>
    implements $ManageEventCopyWith<$Res> {
  factory _$$RefreshTasksImplCopyWith(
          _$RefreshTasksImpl value, $Res Function(_$RefreshTasksImpl) then) =
      __$$RefreshTasksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userUID});
}

/// @nodoc
class __$$RefreshTasksImplCopyWithImpl<$Res>
    extends _$ManageEventCopyWithImpl<$Res, _$RefreshTasksImpl>
    implements _$$RefreshTasksImplCopyWith<$Res> {
  __$$RefreshTasksImplCopyWithImpl(
      _$RefreshTasksImpl _value, $Res Function(_$RefreshTasksImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUID = null,
  }) {
    return _then(_$RefreshTasksImpl(
      null == userUID
          ? _value.userUID
          : userUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RefreshTasksImpl implements RefreshTasks {
  const _$RefreshTasksImpl(this.userUID);

  @override
  final String userUID;

  @override
  String toString() {
    return 'ManageEvent.refreshTasks(userUID: $userUID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTasksImpl &&
            (identical(other.userUID, userUID) || other.userUID == userUID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userUID);

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshTasksImplCopyWith<_$RefreshTasksImpl> get copyWith =>
      __$$RefreshTasksImplCopyWithImpl<_$RefreshTasksImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userUID) loadTasks,
    required TResult Function(String title, String userUID) addTask,
    required TResult Function(String taskId, String status, String userUID)
        updateTaskStatus,
    required TResult Function(String taskId, String userUID) deleteTask,
    required TResult Function(String userUID) refreshTasks,
  }) {
    return refreshTasks(userUID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userUID)? loadTasks,
    TResult? Function(String title, String userUID)? addTask,
    TResult? Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult? Function(String taskId, String userUID)? deleteTask,
    TResult? Function(String userUID)? refreshTasks,
  }) {
    return refreshTasks?.call(userUID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userUID)? loadTasks,
    TResult Function(String title, String userUID)? addTask,
    TResult Function(String taskId, String status, String userUID)?
        updateTaskStatus,
    TResult Function(String taskId, String userUID)? deleteTask,
    TResult Function(String userUID)? refreshTasks,
    required TResult orElse(),
  }) {
    if (refreshTasks != null) {
      return refreshTasks(userUID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTasks value) loadTasks,
    required TResult Function(AddTask value) addTask,
    required TResult Function(UpdateTaskStatus value) updateTaskStatus,
    required TResult Function(DeleteTask value) deleteTask,
    required TResult Function(RefreshTasks value) refreshTasks,
  }) {
    return refreshTasks(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTasks value)? loadTasks,
    TResult? Function(AddTask value)? addTask,
    TResult? Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult? Function(DeleteTask value)? deleteTask,
    TResult? Function(RefreshTasks value)? refreshTasks,
  }) {
    return refreshTasks?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTasks value)? loadTasks,
    TResult Function(AddTask value)? addTask,
    TResult Function(UpdateTaskStatus value)? updateTaskStatus,
    TResult Function(DeleteTask value)? deleteTask,
    TResult Function(RefreshTasks value)? refreshTasks,
    required TResult orElse(),
  }) {
    if (refreshTasks != null) {
      return refreshTasks(this);
    }
    return orElse();
  }
}

abstract class RefreshTasks implements ManageEvent {
  const factory RefreshTasks(final String userUID) = _$RefreshTasksImpl;

  @override
  String get userUID;

  /// Create a copy of ManageEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshTasksImplCopyWith<_$RefreshTasksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
