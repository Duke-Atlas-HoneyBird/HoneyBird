import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<dynamic>? _authStateSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignInRequested>(_onAuthSignInRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
    on<AuthPasswordResetRequested>(_onAuthPasswordResetRequested);
    on<AuthEmailVerificationRequested>(_onAuthEmailVerificationRequested);
    on<AuthUserChanged>(_onAuthUserChanged);

    _authStateSubscription = _authRepository.authStateChanges.listen((user) {
      add(AuthEvent.userChanged(user));
    });
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(state.copyWith(user: event.user, errorMessage: null));
    } else {
      emit(state.copyWith(user: null, errorMessage: null));
    }
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.getCurrentUser();

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: failure.message, user: null)),
      (user) => emit(state.copyWith(
          isLoading: false, user: user, errorMessage: null)),
    );
  }

  Future<void> _onAuthSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: failure.message)),
      (user) => emit(state.copyWith(isLoading: false, user: user)),
    );
  }

  Future<void> _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.signUpWithEmailAndPassword(
      email: event.email,
      password: event.password,
      displayName: event.displayName,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: failure.message)),
      (user) => emit(state.copyWith(isLoading: false, user: user)),
    );
  }

  Future<void> _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.signOut();

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isLoading: false, user: null)),
    );
  }

  Future<void> _onAuthPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.sendPasswordResetEmail(event.email);

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(
          isLoading: false, passwordResetEmail: event.email)),
    );
  }

  Future<void> _onAuthEmailVerificationRequested(
    AuthEmailVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.sendEmailVerification();

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(
          isLoading: false, emailVerificationSent: true)),
    );
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
