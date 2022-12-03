part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginFailedState extends AuthState {
  final String error;
  LoginFailedState({required this.error});
}

class UserNotFountState extends AuthState {}

class InvalidPasswordState extends AuthState {}

class EmailAlreadyExistState extends AuthState {}

class EmailSignUpFailedState extends AuthState {
  final String error;
  EmailSignUpFailedState({required this.error});
}

class WeakPasswordState extends AuthState {}

class EmailSignUpCompletedState extends AuthState {}

class EmailSignUpLoadingState extends AuthState {}

class UsernameAlreadyExistState extends AuthState {}

class LoginCodeSentState extends AuthState {}

class LoggedInState extends AuthState {
  final User firebaseUser;
  LoggedInState({required this.firebaseUser});
}

class LoggedOutState extends AuthState {}

class NewUserCreatedState extends AuthState {
  final User firebaseUser;
  NewUserCreatedState({required this.firebaseUser});
}

class CompletedLoadingState extends AuthState {}
