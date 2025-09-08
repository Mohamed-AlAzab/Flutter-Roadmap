import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final AuthRepository authRepository;
  // ignore: unused_field
  // User? _currentUser;
  // {required this.authRepository}

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(onLoginEvent);
    on<RegisterEvent>(onSignupEvent);
    on<ForgotPasswordEvent>(onForgotPasswordEvent);
    on<LogoutEvent>(onLogoutEvent);
    on<DeleteAccount>(onDeleteAccountEvent);
    on<SignInWithGoogleEvent>(onSignInWithGoogleEvent);
    on<AuthCheckEvent>(onAuthCheckEvent);
  }

  FutureOr<void> onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 2));
    emit(Authenticated());
  }

  FutureOr<void> onSignupEvent(RegisterEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> onForgotPasswordEvent(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) {}

  FutureOr<void> onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> onDeleteAccountEvent(
    DeleteAccount event,
    Emitter<AuthState> emit,
  ) {}

  FutureOr<void> onSignInWithGoogleEvent(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) {}

  FutureOr<void> onAuthCheckEvent(
    AuthCheckEvent event,
    Emitter<AuthState> emit,
  ) {}
}
