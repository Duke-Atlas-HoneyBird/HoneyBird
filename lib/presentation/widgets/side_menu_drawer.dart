import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

/// A side menu drawer that slides in from the right with navigation options
/// Includes haptic feedback on menu item selection
class SideMenuDrawer extends StatelessWidget {
  final Function(String route) onNavigate;

  const SideMenuDrawer({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Row(
                  children: [
                    const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    Text(
                      'Menu',
                      style: AppTheme.headlineMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.white24,
                thickness: 1,
              ),
              
              // Menu items
              _buildMenuItem(
                context,
                icon: Icons.account_circle,
                title: 'Account',
                route: '/account',
              ),
              _buildMenuItem(
                context,
                icon: Icons.settings,
                title: 'Manage',
                route: '/manage',
              ),
              _buildMenuItem(
                context,
                icon: Icons.timeline,
                title: 'Timeline',
                route: '/timeline',
              ),
              _buildMenuItem(
                context,
                icon: Icons.feed,
                title: 'Feed',
                route: '/feed',
              ),
              
              const Spacer(),
              
              // Footer
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Text(
                  'HoneyBird v2.0.0',
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: AppTheme.iconSize,
      ),
      title: Text(
        title,
        style: AppTheme.bodyLarge.copyWith(
          color: Colors.white,
        ),
      ),
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.pop(context); // Close drawer
        onNavigate(route);
      },
      hoverColor: Colors.white12,
      splashColor: Colors.white24,
      minVerticalPadding: 16.0, // Ensure proper touch target height
    );
  }
}
