import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/account/account_bloc.dart';
import '../bloc/account/account_event.dart';
import '../bloc/account/account_state.dart';
import '../screens/onboarding_screen.dart';

/// Root gate used via [MaterialApp.builder].
///
/// When the user is signed in and onboarding is incomplete (or still loading),
/// this replaces the navigator entirely so Home and other routes cannot flash
/// underneath. Once onboarding is complete, [child] (the app navigator) is shown.
class OnboardingRootGate extends StatefulWidget {
  final Widget? child;

  const OnboardingRootGate({super.key, required this.child});

  @override
  State<OnboardingRootGate> createState() => _OnboardingRootGateState();
}

class _OnboardingRootGateState extends State<OnboardingRootGate> {
  String? _checkedUserId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.user?.uid != curr.user?.uid,
      listener: (context, authState) {
        final user = authState.user;
        if (user == null) {
          _checkedUserId = null;
          return;
        }
        if (_checkedUserId == user.uid) return;
        _checkedUserId = user.uid;
        context
            .read<AccountBloc>()
            .add(AccountEvent.checkOnboardingStatus(user.uid));
      },
      buildWhen: (prev, curr) => prev.user?.uid != curr.user?.uid,
      builder: (context, authState) {
        final user = authState.user;
        if (user == null) {
          return widget.child ?? const SizedBox.shrink();
        }

        // Cold start: user may already be set before the first listen.
        if (_checkedUserId != user.uid) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted || _checkedUserId == user.uid) return;
            _checkedUserId = user.uid;
            context
                .read<AccountBloc>()
                .add(AccountEvent.checkOnboardingStatus(user.uid));
          });
        }

        return BlocBuilder<AccountBloc, AccountState>(
          buildWhen: (prev, curr) =>
              prev.hasCompletedOnboarding != curr.hasCompletedOnboarding ||
              prev.isLoading != curr.isLoading,
          builder: (context, accountState) {
            // Treat unknown status as loading so Home never mounts first.
            if (accountState.hasCompletedOnboarding == null) {
              return const Scaffold(
                body: SafeArea(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }

            if (accountState.hasCompletedOnboarding == false) {
              return OnboardingScreen(userId: user.uid);
            }

            return widget.child ?? const SizedBox.shrink();
          },
        );
      },
    );
  }
}
