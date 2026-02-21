import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../theme/colours.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../theme/constants.dart';

/// A custom bottom navigation bar with four tabs
/// Includes haptic feedback on tab selection
class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onTabSelected;

  const BottomNavigationWidget({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [Icons.home, Icons.favorite, Icons.person, Icons.message];
    final labels = ['Home', 'Favorites', 'Profile', 'Messages'];
    return Container(
      decoration: BoxDecoration(
        color: cardBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: List.generate(icons.length, (index) {
            final isActive = index == currentIndex;
            return Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onTabSelected(index);
                  },
                  borderRadius: BorderRadius.circular(16),
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  splashColor: selectedTab.withValues(alpha: 0.12),
                  highlightColor: Colors.transparent,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                    decoration: BoxDecoration(
                      color: isActive ? selectedTab.withValues(alpha: 0.14) : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icons[index],
                          color: isActive ? selectedTab : unselectedTab,
                        ),
                        const SizedBox(height: spacingXs),
                        Text(
                          labels[index],
                          style: isActive
                              ? bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: selectedTab,
                                )
                              : bodyMedium.copyWith(
                                  color: unselectedTab,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
