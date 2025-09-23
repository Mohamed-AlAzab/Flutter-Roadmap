import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_roadmap/core/constant/string.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/delete_account_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/login_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/logout_user_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/reset_password_by_email_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/signin_with_github_usecase.dart';
import 'package:flutter_roadmap/features/auth/domain/usecase/signin_with_google_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  GetCurrentUserUsecase getCurrentUserUsecase;
  LoginUserUsecase loginUserUsecase;
  RegisterUserUsecase registerUserUsecase;
  ResetPasswordByEmailUsecase resetPasswordByEmailUsecase;
  LogoutUserUsecase logoutUserUsecase;
  DeleteAccountUsecase deleteAccountUsecase;
  SigninWithGoogleUsecase signinWithGoogleUsecase;
  SigninWithGithubUsecase signInWithGithubUsecase;

  AuthBloc({
    required this.getCurrentUserUsecase,
    required this.loginUserUsecase,
    required this.registerUserUsecase,
    required this.resetPasswordByEmailUsecase,
    required this.logoutUserUsecase,
    required this.deleteAccountUsecase,
    required this.signinWithGoogleUsecase,
    required this.signInWithGithubUsecase,
  }) : super(AuthInitial()) {
    on<CheckAuthEvent>(onAuthCheckEvent);
    on<LoginEvent>(onLoginEvent);
    on<RegisterEvent>(onSignupEvent);
    on<ResetPasswordEvent>(onForgotPasswordEvent);
    on<LogoutEvent>(onLogoutEvent);
    on<DeleteAccount>(onDeleteAccountEvent);
    on<SignInWithGoogleEvent>(onSignInWithGoogleEvent);
    on<SignInWithGithubEvent>(onSignInWithGithubEvent);
  }

  FutureOr<void> onAuthCheckEvent(
    CheckAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await getCurrentUserUsecase();
      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated(null));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  FutureOr<void> onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUserUsecase(event.email, event.password);
      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated('Wrong email or password'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  FutureOr<void> onSignupEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await registerUserUsecase(
        event.name,
        event.email,
        event.password,
      );
      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated('Sign up'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  FutureOr<void> onForgotPasswordEvent(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      String text = await resetPasswordByEmailUsecase(event.email);
      if (text == resetPasswordByEmailString) {
        emit(ResetPasswordState(resetPasswordByEmailString));
      } else {
        emit(ResetPasswordState('Error occurred try again'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      debugPrint(e.toString());
    }
  }

  FutureOr<void> onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await logoutUserUsecase();
      emit(Unauthenticated(null));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  FutureOr<void> onDeleteAccountEvent(
    DeleteAccount event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await deleteAccountUsecase();
      emit(Unauthenticated('Account deleted successfully'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  FutureOr<void> onSignInWithGoogleEvent(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await signinWithGoogleUsecase();
      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated('Failed to login with google'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      debugPrint(e.toString());
    }
  }

  FutureOr<void> onSignInWithGithubEvent(
    SignInWithGithubEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await signInWithGithubUsecase();
      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated('Error With github'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      debugPrint("Error: ${e.toString()}");
    }
  }
}
