// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadRequested,
    required TResult Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)
        createRequested,
    required TResult Function(String postId) likeRequested,
    required TResult Function(String postId) deleteRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadRequested,
    TResult? Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)?
        createRequested,
    TResult? Function(String postId)? likeRequested,
    TResult? Function(String postId)? deleteRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadRequested,
    TResult Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)?
        createRequested,
    TResult Function(String postId)? likeRequested,
    TResult Function(String postId)? deleteRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostsLoadRequested value) loadRequested,
    required TResult Function(PostCreateRequested value) createRequested,
    required TResult Function(PostLikeRequested value) likeRequested,
    required TResult Function(PostDeleteRequested value) deleteRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostsLoadRequested value)? loadRequested,
    TResult? Function(PostCreateRequested value)? createRequested,
    TResult? Function(PostLikeRequested value)? likeRequested,
    TResult? Function(PostDeleteRequested value)? deleteRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostsLoadRequested value)? loadRequested,
    TResult Function(PostCreateRequested value)? createRequested,
    TResult Function(PostLikeRequested value)? likeRequested,
    TResult Function(PostDeleteRequested value)? deleteRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostEventCopyWith<$Res> {
  factory $PostEventCopyWith(PostEvent value, $Res Function(PostEvent) then) =
      _$PostEventCopyWithImpl<$Res, PostEvent>;
}

/// @nodoc
class _$PostEventCopyWithImpl<$Res, $Val extends PostEvent>
    implements $PostEventCopyWith<$Res> {
  _$PostEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PostsLoadRequestedImplCopyWith<$Res> {
  factory _$$PostsLoadRequestedImplCopyWith(_$PostsLoadRequestedImpl value,
          $Res Function(_$PostsLoadRequestedImpl) then) =
      __$$PostsLoadRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PostsLoadRequestedImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$PostsLoadRequestedImpl>
    implements _$$PostsLoadRequestedImplCopyWith<$Res> {
  __$$PostsLoadRequestedImplCopyWithImpl(_$PostsLoadRequestedImpl _value,
      $Res Function(_$PostsLoadRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PostsLoadRequestedImpl implements PostsLoadRequested {
  const _$PostsLoadRequestedImpl();

  @override
  String toString() {
    return 'PostEvent.loadRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PostsLoadRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadRequested,
    required TResult Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)
        createRequested,
    required TResult Function(String postId) likeRequested,
    required TResult Function(String postId) deleteRequested,
  }) {
    return loadRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadRequested,
    TResult? Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)?
        createRequested,
    TResult? Function(String postId)? likeRequested,
    TResult? Function(String postId)? deleteRequested,
  }) {
    return loadRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadRequested,
    TResult Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)?
        createRequested,
    TResult Function(String postId)? likeRequested,
    TResult Function(String postId)? deleteRequested,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostsLoadRequested value) loadRequested,
    required TResult Function(PostCreateRequested value) createRequested,
    required TResult Function(PostLikeRequested value) likeRequested,
    required TResult Function(PostDeleteRequested value) deleteRequested,
  }) {
    return loadRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostsLoadRequested value)? loadRequested,
    TResult? Function(PostCreateRequested value)? createRequested,
    TResult? Function(PostLikeRequested value)? likeRequested,
    TResult? Function(PostDeleteRequested value)? deleteRequested,
  }) {
    return loadRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostsLoadRequested value)? loadRequested,
    TResult Function(PostCreateRequested value)? createRequested,
    TResult Function(PostLikeRequested value)? likeRequested,
    TResult Function(PostDeleteRequested value)? deleteRequested,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(this);
    }
    return orElse();
  }
}

abstract class PostsLoadRequested implements PostEvent {
  const factory PostsLoadRequested() = _$PostsLoadRequestedImpl;
}

/// @nodoc
abstract class _$$PostCreateRequestedImplCopyWith<$Res> {
  factory _$$PostCreateRequestedImplCopyWith(_$PostCreateRequestedImpl value,
          $Res Function(_$PostCreateRequestedImpl) then) =
      __$$PostCreateRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text, String? imageUrl, File? imageFile, File? videoFile});
}

/// @nodoc
class __$$PostCreateRequestedImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$PostCreateRequestedImpl>
    implements _$$PostCreateRequestedImplCopyWith<$Res> {
  __$$PostCreateRequestedImplCopyWithImpl(_$PostCreateRequestedImpl _value,
      $Res Function(_$PostCreateRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? imageUrl = freezed,
    Object? imageFile = freezed,
    Object? videoFile = freezed,
  }) {
    return _then(_$PostCreateRequestedImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageFile: freezed == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as File?,
      videoFile: freezed == videoFile
          ? _value.videoFile
          : videoFile // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$PostCreateRequestedImpl implements PostCreateRequested {
  const _$PostCreateRequestedImpl(
      {required this.text, this.imageUrl, this.imageFile, this.videoFile});

  @override
  final String text;
  @override
  final String? imageUrl;
  @override
  final File? imageFile;
  @override
  final File? videoFile;

  @override
  String toString() {
    return 'PostEvent.createRequested(text: $text, imageUrl: $imageUrl, imageFile: $imageFile, videoFile: $videoFile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostCreateRequestedImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.imageFile, imageFile) ||
                other.imageFile == imageFile) &&
            (identical(other.videoFile, videoFile) ||
                other.videoFile == videoFile));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, text, imageUrl, imageFile, videoFile);

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostCreateRequestedImplCopyWith<_$PostCreateRequestedImpl> get copyWith =>
      __$$PostCreateRequestedImplCopyWithImpl<_$PostCreateRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadRequested,
    required TResult Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)
        createRequested,
    required TResult Function(String postId) likeRequested,
    required TResult Function(String postId) deleteRequested,
  }) {
    return createRequested(text, imageUrl, imageFile, videoFile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadRequested,
    TResult? Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)?
        createRequested,
    TResult? Function(String postId)? likeRequested,
    TResult? Function(String postId)? deleteRequested,
  }) {
    return createRequested?.call(text, imageUrl, imageFile, videoFile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadRequested,
    TResult Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)?
        createRequested,
    TResult Function(String postId)? likeRequested,
    TResult Function(String postId)? deleteRequested,
    required TResult orElse(),
  }) {
    if (createRequested != null) {
      return createRequested(text, imageUrl, imageFile, videoFile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostsLoadRequested value) loadRequested,
    required TResult Function(PostCreateRequested value) createRequested,
    required TResult Function(PostLikeRequested value) likeRequested,
    required TResult Function(PostDeleteRequested value) deleteRequested,
  }) {
    return createRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostsLoadRequested value)? loadRequested,
    TResult? Function(PostCreateRequested value)? createRequested,
    TResult? Function(PostLikeRequested value)? likeRequested,
    TResult? Function(PostDeleteRequested value)? deleteRequested,
  }) {
    return createRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostsLoadRequested value)? loadRequested,
    TResult Function(PostCreateRequested value)? createRequested,
    TResult Function(PostLikeRequested value)? likeRequested,
    TResult Function(PostDeleteRequested value)? deleteRequested,
    required TResult orElse(),
  }) {
    if (createRequested != null) {
      return createRequested(this);
    }
    return orElse();
  }
}

abstract class PostCreateRequested implements PostEvent {
  const factory PostCreateRequested(
      {required final String text,
      final String? imageUrl,
      final File? imageFile,
      final File? videoFile}) = _$PostCreateRequestedImpl;

  String get text;
  String? get imageUrl;
  File? get imageFile;
  File? get videoFile;

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostCreateRequestedImplCopyWith<_$PostCreateRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostLikeRequestedImplCopyWith<$Res> {
  factory _$$PostLikeRequestedImplCopyWith(_$PostLikeRequestedImpl value,
          $Res Function(_$PostLikeRequestedImpl) then) =
      __$$PostLikeRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId});
}

/// @nodoc
class __$$PostLikeRequestedImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$PostLikeRequestedImpl>
    implements _$$PostLikeRequestedImplCopyWith<$Res> {
  __$$PostLikeRequestedImplCopyWithImpl(_$PostLikeRequestedImpl _value,
      $Res Function(_$PostLikeRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
  }) {
    return _then(_$PostLikeRequestedImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostLikeRequestedImpl implements PostLikeRequested {
  const _$PostLikeRequestedImpl({required this.postId});

  @override
  final String postId;

  @override
  String toString() {
    return 'PostEvent.likeRequested(postId: $postId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostLikeRequestedImpl &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId);

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostLikeRequestedImplCopyWith<_$PostLikeRequestedImpl> get copyWith =>
      __$$PostLikeRequestedImplCopyWithImpl<_$PostLikeRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadRequested,
    required TResult Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)
        createRequested,
    required TResult Function(String postId) likeRequested,
    required TResult Function(String postId) deleteRequested,
  }) {
    return likeRequested(postId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadRequested,
    TResult? Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)?
        createRequested,
    TResult? Function(String postId)? likeRequested,
    TResult? Function(String postId)? deleteRequested,
  }) {
    return likeRequested?.call(postId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadRequested,
    TResult Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)?
        createRequested,
    TResult Function(String postId)? likeRequested,
    TResult Function(String postId)? deleteRequested,
    required TResult orElse(),
  }) {
    if (likeRequested != null) {
      return likeRequested(postId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostsLoadRequested value) loadRequested,
    required TResult Function(PostCreateRequested value) createRequested,
    required TResult Function(PostLikeRequested value) likeRequested,
    required TResult Function(PostDeleteRequested value) deleteRequested,
  }) {
    return likeRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostsLoadRequested value)? loadRequested,
    TResult? Function(PostCreateRequested value)? createRequested,
    TResult? Function(PostLikeRequested value)? likeRequested,
    TResult? Function(PostDeleteRequested value)? deleteRequested,
  }) {
    return likeRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostsLoadRequested value)? loadRequested,
    TResult Function(PostCreateRequested value)? createRequested,
    TResult Function(PostLikeRequested value)? likeRequested,
    TResult Function(PostDeleteRequested value)? deleteRequested,
    required TResult orElse(),
  }) {
    if (likeRequested != null) {
      return likeRequested(this);
    }
    return orElse();
  }
}

abstract class PostLikeRequested implements PostEvent {
  const factory PostLikeRequested({required final String postId}) =
      _$PostLikeRequestedImpl;

  String get postId;

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostLikeRequestedImplCopyWith<_$PostLikeRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostDeleteRequestedImplCopyWith<$Res> {
  factory _$$PostDeleteRequestedImplCopyWith(_$PostDeleteRequestedImpl value,
          $Res Function(_$PostDeleteRequestedImpl) then) =
      __$$PostDeleteRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String postId});
}

/// @nodoc
class __$$PostDeleteRequestedImplCopyWithImpl<$Res>
    extends _$PostEventCopyWithImpl<$Res, _$PostDeleteRequestedImpl>
    implements _$$PostDeleteRequestedImplCopyWith<$Res> {
  __$$PostDeleteRequestedImplCopyWithImpl(_$PostDeleteRequestedImpl _value,
      $Res Function(_$PostDeleteRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
  }) {
    return _then(_$PostDeleteRequestedImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostDeleteRequestedImpl implements PostDeleteRequested {
  const _$PostDeleteRequestedImpl({required this.postId});

  @override
  final String postId;

  @override
  String toString() {
    return 'PostEvent.deleteRequested(postId: $postId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostDeleteRequestedImpl &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId);

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostDeleteRequestedImplCopyWith<_$PostDeleteRequestedImpl> get copyWith =>
      __$$PostDeleteRequestedImplCopyWithImpl<_$PostDeleteRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadRequested,
    required TResult Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)
        createRequested,
    required TResult Function(String postId) likeRequested,
    required TResult Function(String postId) deleteRequested,
  }) {
    return deleteRequested(postId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadRequested,
    TResult? Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)?
        createRequested,
    TResult? Function(String postId)? likeRequested,
    TResult? Function(String postId)? deleteRequested,
  }) {
    return deleteRequested?.call(postId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadRequested,
    TResult Function(
            String text, String? imageUrl, File? imageFile, File? videoFile)?
        createRequested,
    TResult Function(String postId)? likeRequested,
    TResult Function(String postId)? deleteRequested,
    required TResult orElse(),
  }) {
    if (deleteRequested != null) {
      return deleteRequested(postId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostsLoadRequested value) loadRequested,
    required TResult Function(PostCreateRequested value) createRequested,
    required TResult Function(PostLikeRequested value) likeRequested,
    required TResult Function(PostDeleteRequested value) deleteRequested,
  }) {
    return deleteRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostsLoadRequested value)? loadRequested,
    TResult? Function(PostCreateRequested value)? createRequested,
    TResult? Function(PostLikeRequested value)? likeRequested,
    TResult? Function(PostDeleteRequested value)? deleteRequested,
  }) {
    return deleteRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostsLoadRequested value)? loadRequested,
    TResult Function(PostCreateRequested value)? createRequested,
    TResult Function(PostLikeRequested value)? likeRequested,
    TResult Function(PostDeleteRequested value)? deleteRequested,
    required TResult orElse(),
  }) {
    if (deleteRequested != null) {
      return deleteRequested(this);
    }
    return orElse();
  }
}

abstract class PostDeleteRequested implements PostEvent {
  const factory PostDeleteRequested({required final String postId}) =
      _$PostDeleteRequestedImpl;

  String get postId;

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostDeleteRequestedImplCopyWith<_$PostDeleteRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
