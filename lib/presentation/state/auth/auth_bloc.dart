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
        super(const AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignInRequested>(_onAuthSignInRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
    on<AuthPasswordResetRequested>(_onAuthPasswordResetRequested);
    on<AuthEmailVerificationRequested>(_onAuthEmailVerificationRequested);

    // Listen to auth state changes
    _authStateSubscription = _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        add(_AuthUserChanged(user: user));
      } else {
        add(const _AuthUserChanged(user: null));
      }
    });
    
    // Add internal event handler for auth state changes
    on<_AuthUserChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthAuthenticated(user: event.user!));
      } else {
        emit(const AuthUnauthenticated());
      }
    });
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await _authRepository.getCurrentUser();
    
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  Future<void> _onAuthSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await _authRepository.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
    
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await _authRepository.signUpWithEmailAndPassword(
      email: event.email,
      password: event.password,
      displayName: event.displayName,
    );
    
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await _authRepository.signOut();
    
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  Future<void> _onAuthPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await _authRepository.sendPasswordResetEmail(event.email);
    
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(AuthPasswordResetSent(email: event.email)),
    );
  }

  Future<void> _onAuthEmailVerificationRequested(
    AuthEmailVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await _authRepository.sendEmailVerification();
    
    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(const AuthEmailVerificationSent()),
    );
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}

// Internal event for auth state changes
class _AuthUserChanged extends AuthEvent {
  final dynamic user;

  const _AuthUserChanged({required this.user});

  @override
  List<Object?> get props => [user];
}