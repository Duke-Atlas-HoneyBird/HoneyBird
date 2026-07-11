import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import '../theme/constants.dart';

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
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(spacingL),
                child: Row(
                  children: [
                    Icon(
                      Icons.menu,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 32,
                    ),
                    const SizedBox(width: spacingM),
                    Text(
                      'Menu',
                      style: headlineMedium.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).dividerColor,
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
                padding: const EdgeInsets.all(spacingL),
                child: FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    final version = snapshot.hasData
                        ? snapshot.data?.version ?? '...'
                        : '...';
                    return Text(
                      'HoneyBird v$version',
                      style: bodyMedium.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    );
                  },
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
        color: Theme.of(context).colorScheme.onBackground,
        size: iconSize,
      ),
      title: Text(
        title,
        style: bodyLarge.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.pop(context); // Close drawer
        onNavigate(route);
      },
      hoverColor: Theme.of(context).dividerColor.withValues(alpha: 0.1),
      splashColor: Theme.of(context).dividerColor.withValues(alpha: 0.2),
      minVerticalPadding: 16.0, // Ensure proper touch target height
    );
  }
}
