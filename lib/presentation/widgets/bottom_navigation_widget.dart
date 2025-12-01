import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

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
        color: AppTheme.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
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
                  borderRadius: BorderRadius.circular(32),
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  splashColor: AppTheme.selectedTab.withOpacity(0.12),
                  highlightColor: Colors.transparent,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                    decoration: BoxDecoration(
                      color: isActive ? AppTheme.selectedTab.withOpacity(0.14) : Colors.transparent,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icons[index],
                          color: isActive ? AppTheme.selectedTab : AppTheme.unselectedTab,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          labels[index],
                          style: isActive
                              ? AppTheme.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.selectedTab,
                                )
                              : AppTheme.bodyMedium.copyWith(
                                  color: AppTheme.unselectedTab,
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
