import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      buildWhen: (prev, curr) =>
          prev?.user != curr.user || prev?.isLoading != curr.isLoading,
      builder: (context, state) {
        if (state.isLoading && state.user == null) {
          return const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state.user == null) {
          return const AuthScreen();
        }
        return child;
      },
    );
  }
}