import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/auth/auth_bloc.dart';
import '../state/auth/auth_state.dart';
import '../screens/auth_screen.dart';

/// Wrapper widget that shows authentication screen or main content based on auth state
class AuthWrapper extends StatelessWidget {
  final Widget child;

  const AuthWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        if (state is AuthUnauthenticated || state is AuthError) {
          return const AuthScreen();
        }
        
        if (state is AuthAuthenticated) {
          return child;
        }
        
        // Initial state - show loading
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}