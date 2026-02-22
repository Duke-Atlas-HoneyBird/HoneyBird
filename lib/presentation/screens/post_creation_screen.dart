import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/di/injection.dart';
import '../../core/utils/snackbar_utils.dart';
import '../../application/use_cases/post/create_post.dart';
import '../../domain/entities/post.dart';
import '../../infrastructure/data_sources/firebase_storage_data_source.dart';
import '../state/auth/auth_bloc.dart';
import '../state/auth/auth_state.dart';
import '../theme/colours.dart';
import '../theme/constants.dart';
import '../theme/spacing.dart';
import '../theme/border_radius.dart';
import '../theme/text_styles.dart';

const int _maxCaptionLength = 1000;

/// Screen for creating new posts.
/// Supports text (caption), image, and video — caption optional when media is present.
/// Image frame is mobile-first. Camera and gallery for image/video. Includes haptic feedback.
class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  File? _pickedImage;
  File? _pickedVideo;

  late final CreatePost _createPost;
  late final FirebaseStorageDataSource _storage;
  void _onCaptionChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    _createPost = sl<CreatePost>();
    _storage = sl<FirebaseStorageDataSource>();
    _textController.addListener(_onCaptionChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onCaptionChanged);
    _textController.dispose();
    super.dispose();
  }

  bool get _canSubmit {
    final text = _textController.text.trim();
    final hasMedia = _pickedImage != null || _pickedVideo != null;
    if (text.isEmpty && !hasMedia) return false;
    if (text.isNotEmpty && text.length < 2) return false;
    if (text.length > _maxCaptionLength) return false;
    return true;
  }

  Future<void> _showImageSourcePicker() async {
    HapticFeedback.lightImpact();
    if (_isLoading) return;
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null || !mounted) return;
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: source);
    if (xFile == null || !mounted) return;
    setState(() {
      _pickedImage = File(xFile.path);
      _pickedVideo = null;
    });
  }

  Future<void> _handleSubmit() async {
    HapticFeedback.mediumImpact();
    if (!_formKey.currentState!.validate()) {
      HapticFeedback.heavyImpact();
      return;
    }

    final authState = context.read<AuthBloc>().state;
    if (authState.user == null) {
      SnackBarUtils.showError(context, 'Please sign in to post.');
      return;
    }

    final user = authState.user!;
    final userId = user.uid;
    final userName = user.displayName ?? user.email.split('@').first;

    setState(() {
      _isLoading = true;
    });

    Uri? imageURL;
    Uri? videoURL;

    try {
      if (_pickedImage != null) {
        imageURL = await _storage.uploadPostImage(_pickedImage!, userId);
      }
      if (_pickedVideo != null) {
        videoURL = await _storage.uploadPostVideo(_pickedVideo!, userId);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      SnackBarUtils.showError(context, 'Upload failed. Please try again.');
      return;
    }

    final post = Post(
      text: _textController.text.trim(),
      publishedDate: DateTime.now(),
      userName: userName,
      userUID: userId,
      imageURL: imageURL,
      imageReferenceID: imageURL != null ? imageURL.toString() : '',
      videoURL: videoURL,
      videoReferenceID: videoURL != null ? videoURL.toString() : '',
      likeIDs: const [],
    );

    final result = await _createPost(post);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    result.fold(
      (failure) {
        SnackBarUtils.showError(
          context,
          'Failed to create post. Please try again.',
        );
      },
      (_) {
        SnackBarUtils.showSuccess(context, 'Post created!');
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            iconSize: 48,
          ),
          title: const Text('Create Post'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(spacingM),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _pickedImage == null && _pickedVideo == null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _textController,
                                  maxLines: null,
                                  expands: true,
                                  textAlignVertical: TextAlignVertical.top,
                                  decoration: InputDecoration(
                                    hintText: 'Add a caption (optional with media)',
                                    counterText: '',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(buttonBorderRadius),
                                      borderSide: BorderSide(
                                          color: textSecondary.withValues(alpha: 0.3)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(buttonBorderRadius),
                                      borderSide: BorderSide(
                                          color: textSecondary.withValues(alpha: 0.3)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(buttonBorderRadius),
                                      borderSide: const BorderSide(
                                          color: primaryColor, width: 1.5),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(buttonBorderRadius),
                                      borderSide: const BorderSide(color: errorColor),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(buttonBorderRadius),
                                      borderSide: BorderSide(
                                          color: textSecondary.withValues(alpha: 0.2)),
                                    ),
                                  ),
                                  style: bodyLarge,
                                  maxLength: _maxCaptionLength,
                                  validator: (value) {
                                    final text = value?.trim() ?? '';
                                    final hasMedia =
                                        _pickedImage != null || _pickedVideo != null;
                                    if (text.isEmpty && !hasMedia) {
                                      return 'Add some text or a photo/video';
                                    }
                                    if (text.isNotEmpty && text.length < 2) {
                                      return 'Caption must be at least 2 characters';
                                    }
                                    if (text.length > _maxCaptionLength) {
                                      return 'Caption must be under $_maxCaptionLength characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: spacingXs),
                                  child: Text(
                                    '${_textController.text.length} / $_maxCaptionLength',
                                    style: bodyMedium.copyWith(
                                      color: textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 120,
                                    maxHeight: MediaQuery.of(context).size.height * 0.35,
                                  ),
                                  child: TextFormField(
                                    controller: _textController,
                                    maxLines: null,
                                    minLines: 3,
                                    textAlignVertical: TextAlignVertical.top,
                                    decoration: InputDecoration(
                              hintText: 'Add a caption (optional with media)',
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(buttonBorderRadius),
                                borderSide: BorderSide(
                                    color: textSecondary.withValues(alpha: 0.3)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(buttonBorderRadius),
                                borderSide: BorderSide(
                                    color: textSecondary.withValues(alpha: 0.3)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(buttonBorderRadius),
                                borderSide: const BorderSide(
                                    color: primaryColor, width: 1.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(buttonBorderRadius),
                                borderSide: const BorderSide(color: errorColor),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(buttonBorderRadius),
                                borderSide: BorderSide(
                                    color: textSecondary.withValues(alpha: 0.2)),
                              ),
                            ),
                            style: bodyLarge,
                            maxLength: _maxCaptionLength,
                            validator: (value) {
                              final text = value?.trim() ?? '';
                              final hasMedia =
                                  _pickedImage != null || _pickedVideo != null;
                              if (text.isEmpty && !hasMedia) {
                                return 'Add some text or a photo/video';
                              }
                              if (text.isNotEmpty && text.length < 2) {
                                return 'Caption must be at least 2 characters';
                              }
                              if (text.length > _maxCaptionLength) {
                                return 'Caption must be under $_maxCaptionLength characters';
                              }
                              return null;
                            },
                            ),
                          ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: spacingXs),
                            child: Text(
                              '${_textController.text.length} / $_maxCaptionLength',
                              style: bodyMedium.copyWith(
                                color: textSecondary,
                              ),
                            ),
                          ),
                        ),
                        if (_pickedImage != null) ...[
                          const SizedBox(height: spacingS),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(buttonBorderRadius),
                            child: AspectRatio(
                              aspectRatio: 4 / 5,
                              child: Image.file(
                                _pickedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    setState(() {
                                      _pickedImage = null;
                                    });
                                  },
                            icon: const Icon(Icons.close, size: 18),
                            label: const Text('Remove image'),
                          ),
                        ],
                        if (_pickedVideo != null) ...[
                          const SizedBox(height: spacingS),
                    AspectRatio(
                              aspectRatio: 4 / 5,
                              child: Container(
                                color: textSecondary.withValues(alpha: 0.12),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.videocam,
                                        size: 48,
                                        color: textSecondary,
                                      ),
                                      const SizedBox(height: spacingS),
                                      Text(
                                        _pickedVideo!.path.split(RegExp(r'[/\\]')).last,
                                        style: bodyMedium.copyWith(
                                          color: textSecondary,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          
                          TextButton.icon(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    setState(() {
                                      _pickedVideo = null;
                                    });
                                  },
                            icon: const Icon(Icons.close, size: 18),
                            label: const Text('Remove video'),
                          ),
                        ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: spacingS),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: _isLoading ? null : _showImageSourcePicker,
                        icon: const Icon(Icons.image_outlined),
                        label: const Text('Photo'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryColor,
                          side: BorderSide(color: primaryColor),
                          padding: const EdgeInsets.symmetric(
                            horizontal: spacingM,
                            vertical: spacingM,
                          ),
                          minimumSize: const Size(0, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(buttonBorderRadius),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: spacingM),
                  ElevatedButton(
                    onPressed: (_isLoading || !_canSubmit) ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: fabElevation,
                      padding: const EdgeInsets.symmetric(
                        horizontal: spacingL,
                        vertical: spacingM,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(buttonBorderRadius),
                      ),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: _isLoading
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                              const SizedBox(width: spacingS),
                              Text(
                                'Uploading...',
                                style: labelLarge.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Post',
                                style: labelLarge.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: spacingS),
                              const Icon(Icons.send),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
