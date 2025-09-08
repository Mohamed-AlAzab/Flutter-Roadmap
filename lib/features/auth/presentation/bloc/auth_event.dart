part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email, password;
  const LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String email, password; // add name
  const RegisterEvent(this.email, this.password);
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  const ForgotPasswordEvent(this.email);
}

class LogoutEvent extends AuthEvent {}

class DeleteAccount extends AuthEvent {}

class SignInWithGoogleEvent extends AuthEvent {}
