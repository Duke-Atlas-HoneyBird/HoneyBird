import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/account/account_bloc.dart';
import '../bloc/account/account_event.dart';
import '../bloc/account/account_state.dart';
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
  bool _hasRequestedCheck = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasRequestedCheck) {
      final authState = context.read<AuthBloc>().state;
      final user = authState.user;
      if (user != null) {
        _hasRequestedCheck = true;
        context
            .read<AccountBloc>()
            .add(AccountEvent.checkOnboardingStatus(user.uid));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final user = authState.user;
    if (user == null) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<AccountBloc, AccountState>(
      buildWhen: (prev, curr) =>
          prev?.hasCompletedOnboarding != curr.hasCompletedOnboarding ||
          prev?.isLoading != curr.isLoading,
      builder: (context, accountState) {
        if (accountState.isLoading && accountState.hasCompletedOnboarding == null) {
          return const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (accountState.hasCompletedOnboarding == true) {
          return const HomeScreen();
        }

        return OnboardingScreen(userId: user.uid);
      },
    );
  }
}
