import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../theme/border_radius.dart';

class AutocompleteInputField<T extends Object> extends StatefulWidget {
  final List<T> options;
  final String? hintText;
  final Duration? debounceTimer;
  final void Function(T)? onOptionSelected;
  final void Function(String)? onChanged;
  final String Function(T)? displayStringForOption;
  final bool showClearButton;

  const AutocompleteInputField({
    super.key,
    required this.options,
    this.hintText,
    this.debounceTimer,
    this.onOptionSelected,
    this.onChanged,
    this.displayStringForOption,
    this.showClearButton = false,
  });

  @override
  State<AutocompleteInputField<T>> createState() =>
      _AutocompleteInputFieldState<T>();
}

class _AutocompleteInputFieldState<T extends Object>
    extends State<AutocompleteInputField<T>> {
  late Timer debounce;

  @override
  void initState() {
    super.initState();
    debounce = Timer(const Duration(days: 1), () {});
  }

  String _displayString(T option) {
    return widget.displayStringForOption?.call(option) ?? option.toString();
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<T>(
      displayStringForOption: _displayString,
      optionsBuilder: (TextEditingValue textEditingValue) {
        final query = textEditingValue.text.toLowerCase().trim();
        if (query.isEmpty) return Iterable<T>.empty();
        return widget.options.where((T option) {
          return _displayString(option).toLowerCase().contains(query);
        });
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: textEditingController,
          builder: (context, value, child) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              onFieldSubmitted: (String v) => onFieldSubmitted(),
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: spacingM, right: spacingS),
                  child: Icon(
                    Icons.search_rounded,
                    color: textSecondary,
                    size: 22,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                hintText: widget.hintText,
                hintStyle: bodyMedium.copyWith(color: textSecondary),
                fillColor: cardBackground,
                filled: true,
                suffixIcon: widget.showClearButton && value.text.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(right: spacingXs),
                        child: IconButton(
                          icon: const Icon(
                            Icons.clear_rounded,
                            color: textSecondary,
                            size: 20,
                          ),
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            textEditingController.clear();
                            widget.onChanged?.call('');
                          },
                          style: IconButton.styleFrom(
                            minimumSize: const Size(44, 44),
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  borderSide: const BorderSide(color: primaryPurple, width: 2.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: spacingM,
                  vertical: 14,
                ),
              ),
              style: bodyLarge,
              onChanged: (v) {
                debounce.cancel();
                debounce = Timer(
                  widget.debounceTimer ?? const Duration(milliseconds: 300),
                  () => widget.onChanged?.call(v),
                );
              },
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            );
          },
        );
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<T> onSelected,
        Iterable<T> options,
      ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(cardBorderRadius),
            child: Container(
              height: 200.0,
              color: cardBackground,
              width: MediaQuery.of(context).size.width - primaryPadding.horizontal,
              child: ListView.builder(
                padding: const EdgeInsets.all(spacingS),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final T option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                      widget.onOptionSelected?.call(option);
                    },
                    child: ListTile(
                      title: Text(
                        _displayString(option),
                        style: bodyLarge,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    debounce.cancel();
    super.dispose();
  }
}



                       