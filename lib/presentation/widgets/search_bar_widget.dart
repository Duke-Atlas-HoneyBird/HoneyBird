import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/border_radius.dart';
import '../theme/text_styles.dart';

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
        horizontal: spacingM,
        vertical: spacingS,
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onSearch,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          hintStyle: bodyMedium.copyWith(
            color: textSecondary,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: textSecondary,
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: textSecondary,
                  ),
                  onPressed: _clearSearch,
                )
              : null,
          filled: true,
          fillColor: cardBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cardBorderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cardBorderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cardBorderRadius),
            borderSide: const BorderSide(
              color: primaryPurple,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: spacingM,
            vertical: spacingM,
          ),
        ),
        style: bodyLarge,
      ),
    );
  }
}
