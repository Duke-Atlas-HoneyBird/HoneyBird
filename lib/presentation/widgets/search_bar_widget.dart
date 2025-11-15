import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

/// A custom search bar widget with rounded styling and clear functionality
/// Includes haptic feedback on clear action
class SearchBarWidget extends StatefulWidget {
  final Function(String query) onSearch;
  final String placeholder;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
    this.placeholder = 'HoneyBird Search...',
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {}); // Rebuild to show/hide clear button
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearSearch() {
    HapticFeedback.lightImpact();
    _controller.clear();
    widget.onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onSearch,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          hintStyle: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textSecondary,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppTheme.textSecondary,
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: AppTheme.textSecondary,
                  ),
                  onPressed: _clearSearch,
                )
              : null,
          filled: true,
          fillColor: AppTheme.cardBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
            borderSide: const BorderSide(
              color: AppTheme.primaryPurple,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM,
            vertical: AppTheme.spacingM,
          ),
        ),
        style: AppTheme.bodyLarge,
      ),
    );
  }
}
