import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/di/injection.dart';
import '../../core/utils/snackbar_utils.dart';
import '../../application/use_cases/post/create_post.dart';
import '../../domain/entities/post.dart';
import '../theme/app_theme.dart';

/// Screen for creating new posts
/// 
/// Allows users to enter post text and optionally add an image.
/// Validates input and submits to backend via CreatePost use case.
/// Includes haptic feedback on button interactions.
class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Use case injected via GetIt
  late final CreatePost _createPost;

  @override
  void initState() {
    super.initState();
    _createPost = sl<CreatePost>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /// Validate and submit the post
  Future<void> _handleSubmit() async {
    HapticFeedback.mediumImpact();
    
    // Validate form
    if (!_formKey.currentState!.validate()) {
      HapticFeedback.heavyImpact(); // Error feedback
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Create Post entity from form data
    final post = Post(
      text: _textController.text.trim(),
      publishedDate: DateTime.now(),
      userName: 'CurrentUser', // TODO: Get from authenticated user
      userUID: 'user123', // TODO: Get from authenticated user
      imageURL: null, // Image picker not implemented yet
      imageReferenceID: '',
      upvoteIDs: const [],
      downvoteIDs: const [],
    );

    // Call CreatePost use case
    final result = await _createPost(post);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // Handle result
    result.fold(
      (failure) {
        // Show error message
        SnackBarUtils.showError(
          context,
          'Failed to create post. Please try again.',
        );
      },
      (createdPost) {
        // Show success message and navigate back
        SnackBarUtils.showSuccess(context, 'Post created successfully!');
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            iconSize: 48, // Proper touch target
          ),
          title: const Text(
            'Create Post',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Post text input
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.spacingM),
                        child: TextFormField(
                          controller: _textController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            hintText: 'What\'s on your mind?',
                            border: InputBorder.none,
                          ),
                          style: AppTheme.bodyLarge,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter some text for your post';
                            }
                            if (value.trim().length < 3) {
                              return 'Post must be at least 3 characters long';
                            }
                            if (value.trim().length > 1000) {
                              return 'Post must be less than 1000 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppTheme.spacingM),
                  
                  // Image picker button (optional - placeholder for now)
                  OutlinedButton.icon(
                    onPressed: _isLoading ? null : () {
                      HapticFeedback.lightImpact();
                      // TODO: Implement image picker
                      SnackBarUtils.showInfo(context, 'Image picker coming soon!');
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('Add Image (Optional)'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.spacingM,
                      ),
                      minimumSize: const Size.fromHeight(48), // Proper touch target
                    ),
                  ),
                  
                  const SizedBox(height: AppTheme.spacingM),
                  
                  // Submit button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentPink,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.spacingM,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppTheme.buttonBorderRadius,
                        ),
                      ),
                      minimumSize: const Size.fromHeight(48), // Proper touch target
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Post',
                            style: AppTheme.labelLarge,
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
