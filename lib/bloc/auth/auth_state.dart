part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginFailedState extends AuthState {
  final String error;
  LoginFailedState({required this.error});
}

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
