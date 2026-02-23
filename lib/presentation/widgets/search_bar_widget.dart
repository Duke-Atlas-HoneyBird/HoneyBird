import 'package:flutter/material.dart';
import '../theme/spacing.dart';
import 'autocomplete.dart';

/// A custom search bar widget with rounded styling, clear functionality,
/// and autocomplete suggestions. Includes haptic feedback on clear action.
class SearchBarWidget extends StatelessWidget {
  final Function(String query) onSearch;
  final String placeholder;
  final List<String> options;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
    this.placeholder = 'HoneyBird Search...',
    this.options = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: spacingM,
        vertical: spacingS,
      ),
      child: AutocompleteInputField<String>(
        options: options,
        hintText: placeholder,
        debounceTimer: const Duration(milliseconds: 300),
        showClearButton: true,
        onChanged: onSearch,
        onOptionSelected: (option) => onSearch(option),
      ),
    );
  }
}
