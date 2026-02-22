import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injection.dart';
import '../../application/use_cases/preferences/get_preferences.dart';
import '../state/auth/auth_bloc.dart';
import '../state/auth/auth_state.dart';
import '../screens/home_screen.dart';
import '../screens/onboarding_screen.dart';

/// After login, decides whether to show Onboarding (new user, no preferences)
/// or Home (returning user with preferences).
class PostAuthGate extends StatefulWidget {
  const PostAuthGate({super.key});

  @override
  State<PostAuthGate> createState() => _PostAuthGateState();
}

class _PostAuthGateState extends State<PostAuthGate> {
  bool? _hasPreferences;
  bool _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loading) {
      _checkPreferences();
    }
  }

  Future<void> _checkPreferences() async {
    final authState = context.read<AuthBloc>().state;
    if (authState.user == null) {
      if (mounted) setState(() => _loading = false);
      return;
    }

    final result = await sl<GetPreferences>().call(authState.user!.uid);

    if (!mounted) return;

    setState(() {
      _loading = false;
      _hasPreferences = result.isRight();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    if (authState.user == null) {
      return const SizedBox.shrink();
    }

    if (_loading) {
      return const Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (_hasPreferences == true) {
      return const HomeScreen();
    }

    return OnboardingScreen(userId: authState.user!.uid);
  }
}
