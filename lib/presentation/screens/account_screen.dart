import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Account screen for managing user account settings
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Account',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle_outlined,
                size: 64,
                color: Colors.white.withOpacity(0.7),
              ),
              const SizedBox(height: AppTheme.spacingL),
              Text(
                'Account',
                style: AppTheme.headlineMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: AppTheme.spacingM),
              Text(
                'Account settings and preferences',
                style: AppTheme.bodyLarge.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
